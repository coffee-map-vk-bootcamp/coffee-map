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
    
    static func fetchCoffeeShops(completion: @escaping (Result<[CoffeeShopNW]?, Error>) -> Void) {
        dataBase.collection("coffeeShops").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let result = querySnapshot?.documents.compactMap {
                    try? ModelConverter.convert(from: $0) as CoffeeShopNW
                }
                completion(.success(result))
            }
        }
    }
}

private extension FBService {
    
    static func coffeeShopsNW(from snapshot: QuerySnapshot?) -> [CoffeeShopNW]? {
        return snapshot?.documents.compactMap {
            try? ModelConverter.convert(from: $0)
        }
    }
}

final class FBAuthService {
    
    static func login(email: String, password: String, complition: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                complition(.failure(error))
            } else {
                complition(.success("Success"))
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
        })
    }
}
