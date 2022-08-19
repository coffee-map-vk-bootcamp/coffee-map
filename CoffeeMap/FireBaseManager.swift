//
//  FireBaseManager.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import Firebase

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
    private let dataBase = Firestore.firestore()
    
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
        })
    }
}
