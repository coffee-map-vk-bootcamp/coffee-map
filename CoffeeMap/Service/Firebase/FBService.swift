//
//  FBService.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 20.08.2022.
//

import Firebase
import FirebaseFirestore

protocol NetworkManagerDescription {
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void)
}

final class FBService: NetworkManagerDescription {
    let dataBase = Firestore.firestore()
    
    func addCoffeeShopsSubscription(completion: @escaping (Result<[CoffeeShop], Error>) -> Void) {
        dataBase.collection("coffeeShops").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let result = self.coffeeShops(from: querySnapshot) else { return }
                completion(.success(result))
            }
        }
    }

    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        guard let userId = getUserId() else {
            completion(.failure(FirebaseError.userNotLogin))
            return }

        dataBase.collection("users").document(userId).getDocument { document, error in
            guard error == nil else {
                completion(.failure(FirebaseError.userNotFound))
                return
            }

            guard let document = document else {
                completion(.failure(FirebaseError.receivedNilData))
                return
            }

            guard let result: User = try? ModelConverter.convert(from: document) else {
                completion(.failure(FirebaseError.dataParseError))
                return
            }

            completion(.success(result))
        }
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
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

}
