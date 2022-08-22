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
    
    var favoriteCoffeeShops: [CoffeeShop] =  []
}

extension FavoritesCoffeeShopsScreenInteractor: FavoritesCoffeeShopsScreenInteractorInput {
    func fetchCoffeeShops() {
        FBService().addCoffeeShopsSubscription { [weak self] result in
            switch result {
            case .success(let shops):
                self?.output?.getShops(shops)
            case .failure(let  error):
                print(error)
            }
        }
    }
}
