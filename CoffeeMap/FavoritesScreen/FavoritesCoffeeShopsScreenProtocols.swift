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
}

protocol FavoritesCoffeeShopsScreenInteractorInput: AnyObject {
    func obtainCoffeeShops()
}

protocol FavoritesCoffeeShopsScreenInteractorOutput: AnyObject {
    func transferCoffeeShops(_ shops: [CoffeeShop])
}

protocol FavoritesCoffeeShopsScreenRouterInput: AnyObject {
}
