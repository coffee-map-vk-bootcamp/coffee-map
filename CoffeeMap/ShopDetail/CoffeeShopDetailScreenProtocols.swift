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

}

protocol CoffeeShopDetailScreenViewOutput: AnyObject {
    var count: Int { get }
    
    func item(at index: Int) -> DishSection
    func item(at section: Int, with index: Int) -> Dish
    func number(of section: Int) -> Int
    func getCoffeeShop() -> CoffeeShop
    
    func didLoadView()
    func didSelectDish(with item: Dish)
}

protocol CoffeeShopDetailScreenInteractorInput: AnyObject {
    func loadItems() -> [DishSection]
    func getCoffeeShop() -> CoffeeShop    
}

protocol CoffeeShopDetailScreenInteractorOutput: AnyObject {
    
}

protocol CoffeeShopDetailScreenRouterInput: AnyObject {
    func showDetailDish(output: DishConfiguratorModuleOutput, with item: Dish, coffeeShopName: String)
    func showAlert()
}
