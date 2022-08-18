//
//  FireBase extencion.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

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
}

private extension FBService {
    
    static func coffeeShops(from snapshot: QuerySnapshot?) -> [CoffeeShop]? {
        return snapshot?.documents.compactMap {
            try? ModelConverter.convert(from: $0)
        }
    }
            
    enum CoordinatesKeysNW: String {
        case address
        case latitude
        case longitude
        case dishes
        case image
        case name
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
        })
    }
}
