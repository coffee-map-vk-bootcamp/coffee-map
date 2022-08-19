//
//  FireBaseManager.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

enum FireBaseError: Error {
    case userNotLogin
    case userNotFound
    case receivedNilData
    case dataParseError
}

protocol NetworkManagerDescription {
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void)
}

final class FBService: NetworkManagerDescription {
    let dataBase = Firestore.firestore()
    
    func addCoffeeShopsSubscription(completion: @escaping (Result<[CoffeeShop], Error>) -> Void) {
        dataBase.collection("coffeeShops").addSnapshotListener { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let result = self?.coffeeShops(from: querySnapshot) else { return }
                completion(.success(result))
            }
        }
    }

    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        guard let userId = getUserId() else {
            completion(.failure(FireBaseError.userNotLogin))
            return }

        dataBase.collection("users").document(userId).getDocument { document, error in
            guard error == nil else {
                completion(.failure(FireBaseError.userNotFound))
                return
            }

            guard let document = document else {
                completion(.failure(FireBaseError.receivedNilData))
                return
            }

            guard let result: User = try? ModelConverter.convert(from: document) else {
                completion(.failure(FireBaseError.dataParseError))
                return
            }

            completion(.success(result))
        }
    }

    private func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func downloadImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
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
    
    func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
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
    
    func coffeeShops(from snapshot: QuerySnapshot?) -> [CoffeeShop]? {
        return snapshot?.documents.compactMap {
            try? ModelConverter.convert(from: $0)
        }
    }
}

final class FBAuthService {
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Success"))
            }
        }
    }
    
    func createUser(withEmail email: String, username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (_, err) in
            if let err = err {
                print("Failed to create user:", err)
                completion(.failure(err))
                return
            }
            guard let id = Auth.auth().currentUser?.uid else {
                completion(.failure(FireBaseError.userNotFound))
                return
            }
            FBService().dataBase.collection("users").document(id).setData(["name": email])
            completion(.success("Success"))
        })
    }
    
    static func updateUser(id: String, user: User, completion: @escaping (Result<String, Error>) -> Void) {
        let userDict = ["name": user.name, "favoriteCoffeeShops": user.favoriteCoffeeShops, "order": user.orders] as [String: Any]
        FBService().dataBase.collection("users").document(id).setData(userDict, merge: true) { error in
            if error == nil {
                completion(.success("data updated"))
            } else {
                completion(.failure(FireBaseError.dataParseError))
            }
        }
    }
}
