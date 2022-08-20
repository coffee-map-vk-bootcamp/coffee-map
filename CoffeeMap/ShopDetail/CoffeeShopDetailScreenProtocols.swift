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
    func image(at url: String) -> Data?
    func getCoffeeShopImage() -> String
    
    func didLoadView()
    func didSelectDish(with item: Dish)
}

protocol CoffeeShopDetailScreenInteractorInput: AnyObject {
    func loadItems() -> [DishSection]
    func getCoffeeShopImage() -> String
}

protocol CoffeeShopDetailScreenInteractorOutput: AnyObject {
    
}

protocol CoffeeShopDetailScreenRouterInput: AnyObject {
    func showDetailDish(output: DishConfiguratorModuleOutput, with item: Dish)
    func showAlert()
}
