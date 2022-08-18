//
//  FireBase extencion.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import Firebase

struct MockError: Error {
    
}

final class FBService {
    static let dataBase = Firestore.firestore()
    
    static func fetchCoffeeShops(completion: @escaping (Result<[CoffeeShop], Error>) -> Void) {
        dataBase.collection("coffeeShops").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let result = coffeeShops(from: querySnapshot) else { return }
                completion(.success(result))
            }
        }
    }
    
    static func downloadImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        print("Download Started")
        guard let url = URL(string: url) else { return }
        getData(from: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(.success(image))
            }
        }
    }
    
    static func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}

private extension FBService {
    
    static func coffeeShops(from snapshot: QuerySnapshot?) -> [CoffeeShop]? {
        return snapshot?.documents.compactMap {
            try? ModelConverter.convert(from: $0)
        }
    }
}

final class FBAuthService {
    
    static func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Success"))
            }
        }

    }
    
    static func createUser(withEmail email: String, username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (_, err) in
            if let err = err {
                print("Failed to create user:", err)
                completion(.failure(err))
                return
            }
            guard let id = Auth.auth().currentUser?.uid else {
                completion(.failure(MockError()))
                return
            }
            FBService.dataBase.collection("users").document(id).setData(["name": email])
            completion(.success("Success"))
        })
    }
    
    static func updateUser(id: String, user: User, completion: @escaping (Result<String, Error>) -> Void) {
        let userDict = ["id": user.id, "name": user.name, "favoriteCoffeeShops": user.favoriteCoffeeShops, "order": user.orders] as [String: Any]
        FBService.dataBase.collection("users").document(id).setData(userDict, merge: true) { error in
            if error == nil {
                completion(.success("data updated"))
            } else {
                completion(.failure(MockError()))
            }
        }
    }
}
