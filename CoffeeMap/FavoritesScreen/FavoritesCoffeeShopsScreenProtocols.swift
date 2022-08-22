//
//  FavoritesCoffeeShopsScreenProtocols.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import Foundation

protocol FavoritesCoffeeShopsScreenModuleInput {
    var moduleOutput: FavoritesCoffeeShopsScreenModuleOutput? { get }
}

protocol FavoritesCoffeeShopsScreenModuleOutput: AnyObject {
}

protocol FavoritesCoffeeShopsScreenViewInput: AnyObject {
    func setCoffeeShops(_ shops: [CoffeeShop])
}

protocol FavoritesCoffeeShopsScreenViewOutput: AnyObject {
    func getFavoritesCoffeeShops()
    func getCoffeeShops() -> [CoffeeShop]
    func remove(at index: Int)
}

protocol FavoritesCoffeeShopsScreenInteractorInput: AnyObject {
    func fetchCoffeeShops()
}

protocol FavoritesCoffeeShopsScreenInteractorOutput: AnyObject {
    func getShops(_ shops: [CoffeeShop])
}

protocol FavoritesCoffeeShopsScreenRouterInput: AnyObject {
}
