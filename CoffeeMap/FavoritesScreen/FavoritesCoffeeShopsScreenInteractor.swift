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
    
    func obtainCoffeeShops() {
        output?.transferCoffeeShops(favoriteCoffeeShops)
    }
    
}
