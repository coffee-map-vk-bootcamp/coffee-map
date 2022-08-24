//
//  FavoritesCoffeeShopsScreenInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import Foundation

final class FavoritesCoffeeShopsScreenInteractor {
    weak var output: FavoritesCoffeeShopsScreenInteractorOutput?
    var networkService = FBService()
    
    var favoriteCoffeeShops: [CoffeeShop] =  []
}

extension FavoritesCoffeeShopsScreenInteractor: FavoritesCoffeeShopsScreenInteractorInput {
    func fetchCoffeeShops() {
        networkService.addCoffeeShopsSubscription { [weak self] result in
            switch result {
            case .success(let shops):
                self?.networkService.fetchUserData { userResult in
                    switch userResult {
                    case .success(let user):
                        let favoriteShops = shops.filter { user.favoriteCoffeeShops.contains($0.id)}
                        self?.output?.getShops(favoriteShops)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let  error):
                print(error)
            }
        }
    }
}
