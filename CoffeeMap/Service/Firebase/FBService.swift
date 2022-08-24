//
//  FBService.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 20.08.2022.
//

import Firebase
import FirebaseFirestore

protocol NetworkManagerDescription {
    func addCoffeeShopsSubscription(completion: @escaping (Result<[CoffeeShop], Error>) -> Void)

    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void)

    func deleteFavoriteCoffeeShop(with id: String, completion: @escaping (Result<Void, Error>) -> Void)

    func addFavoriteCoffeeShop(with id: String, completion: @escaping (Result<Void, Error>) -> Void)

    func createOrder(with order: Order, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FBService: NetworkManagerDescription {
    let dataBase = Firestore.firestore()

    func createOrder(with order: Order, completion: @escaping (Result<Void, Error>) -> Void) {
        fetchUserData { [weak self] userResult in
            switch userResult {
            case .success(let user):
                var ordersArray = user.orders
                ordersArray.insert(order, at: 0)
                guard let userId = self?.getUserId() else {
                    completion(.failure(FirebaseError.userNotFound))
                    return
                }
                let documentRef = self?.dataBase.collection("users").document(userId)
                let huiArray: [[String: Any]] = ordersArray.compactMap { order in
                    return try? ModelConverter.convert(from: order)
                }
                documentRef?.updateData(["orders": huiArray], completion: { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteFavoriteCoffeeShop(with id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        fetchUserData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                var favorites = user.favoriteCoffeeShops
                favorites.remove(id)
                let favoritesArray = Array(favorites)
                guard let userId = self?.getUserId() else {
                    completion(.failure(FirebaseError.userNotFound))
                    return
                }
                let documentRef = self?.dataBase.collection("users").document(userId)
                documentRef?.updateData(["favoriteCoffeeShops": favoritesArray], completion: { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                })
            }
        }
    }

    func addFavoriteCoffeeShop(with id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        fetchUserData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                var favorites = user.favoriteCoffeeShops
                favorites.insert(id)
                let favoritesArray = Array(favorites)
                guard let userId = self?.getUserId() else {
                    completion(.failure(FirebaseError.userNotFound))
                    return
                }
                let documentRef = self?.dataBase.collection("users").document(userId)
                documentRef?.updateData(["favoriteCoffeeShops": favoritesArray], completion: { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                })
            }
        }
    }
    
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
