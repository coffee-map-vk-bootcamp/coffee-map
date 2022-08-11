//
//  FireBase extencion.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import Firebase

extension Auth {
    func createUser(withEmail email: String, username: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, err) in
            if let err = err {
                print("Failed to create user:", err)
                completion(err)
                return
            }
        })
    }
}

final class fbService{
    static let db = Firestore.firestore()
    static func fetchCoffeeShops(){
        db.collection("coffeeShop").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print(querySnapshot?.documents.count)
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
}
