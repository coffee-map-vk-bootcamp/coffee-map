//
//  FBAuthService.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 20.08.2022.
//

import Firebase
import FirebaseFirestore

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
                completion(.failure(FirebaseError.userNotFound))
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
                completion(.failure(FirebaseError.dataParseError))
            }
        }
    }
    
    static func logout(completion: (Result<Void, Error>) -> Void){
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch (let error){
            completion(.failure(error))
        }
    }
}
