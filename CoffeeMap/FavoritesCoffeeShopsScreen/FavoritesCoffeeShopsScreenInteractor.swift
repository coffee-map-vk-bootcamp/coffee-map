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
    
    var favoriteCoffeeShops: [CoffeeShop] =  [CoffeeShop(name: "БебраКофе",
                                                         address: "Москва, Тверская 14",
                                                         dishes: [], image: "lol.com",
                                                         latitude: 0.0,
                                                         longitude: 0.0),
                                              CoffeeShop(name: "ДоброКофе",
                                                         address: "Москва, Тверская 2",
                                                         dishes: [], image: "lol.com",
                                                         latitude: 0.0,
                                                         longitude: 0.0),
                                              CoffeeShop(name: "КекКофе",
                                                         address: "Москва, Тверская 24",
                                                         dishes: [], image: "lol.com",
                                                         latitude: 0.0,
                                                         longitude: 0.0),
                                              CoffeeShop(name: "ЛолКофе",
                                                         address: "Москва, Думская 4",
                                                         dishes: [], image: "lol.com",
                                                         latitude: 0.0,
                                                         longitude: 0.0),
                                              CoffeeShop(name: "ТиматиКофе",
                                                         address: "Москва, Тверская 4",
                                                         dishes: [], image: "lol.com",
                                                         latitude: 0.0,
                                                         longitude: 0.0)]
}

extension FavoritesCoffeeShopsScreenInteractor: FavoritesCoffeeShopsScreenInteractorInput {
    
    func obtainCoffeeShops() {
        output?.transferCoffeeShops(favoriteCoffeeShops)
    }
    
}
