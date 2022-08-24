//
//  CoffeeShopDetailScreenProtocols.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation

protocol CoffeeShopDetailScreenModuleInput {
    var moduleOutput: CoffeeShopDetailScreenModuleOutput? { get }
}

protocol CoffeeShopDetailScreenModuleOutput: AnyObject {
    
}

protocol CoffeeShopDetailScreenViewInput: AnyObject {
    func setFavoriteCoffeeShops(_ coffeeShops: [CoffeeShop])
}

protocol CoffeeShopDetailScreenViewOutput: AnyObject {
    var count: Int { get }
    
    func item(at index: Int) -> DishSection
    func item(at section: Int, with index: Int) -> Dish
    func number(of section: Int) -> Int
    func getCoffeeShop() -> CoffeeShop
    
    func didLoadView()
    func didSelectDish(with item: Dish)
    func checkIsFavorite()
    func addToFavorites()
    func removeFromFavorites()
}

protocol CoffeeShopDetailScreenInteractorInput: AnyObject {
    func loadItems() -> [DishSection]
    func getCoffeeShop() -> CoffeeShop
    func checkIsFavorite()
    func addToFavorites()
    func removeFromFavorites()
}

protocol CoffeeShopDetailScreenInteractorOutput: AnyObject {
    func setFavoriteCoffeeShops(_ coffeeShops: [CoffeeShop])
}

protocol CoffeeShopDetailScreenRouterInput: AnyObject {
    func showDetailDish(output: DishConfiguratorModuleOutput, with item: Dish)
    func showAlert()
}
