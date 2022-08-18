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
    
    static func downloadImage(from url: String, completeon: @escaping (UIImage) -> Void) {
        print("Download Started")
        guard let url = URL(string: url) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            guard let image = UIImage(data: data) else { return }
            completeon(image)
        }
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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
            guard let id = Auth.auth().currentUser?.uid else { return }
            FBService.dataBase.collection("users").document(id).setData(["name": email])
            completion(.success("Success"))
        })
    }
    
    static func updateUser(id: String, user: User, completion: @escaping (Result<String, Error>) -> Void) {
        let userDict = ["id": user.id, "name": user.name, "favoriteCoffeeShops": user.favoriteCoffeeShops, "order": user.orders] as [String: Any]
        FBService.dataBase.collection("users").document(id).setData(userDict, merge: true)
    }
}
