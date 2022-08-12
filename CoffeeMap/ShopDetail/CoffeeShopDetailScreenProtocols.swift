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
    func image(at url: String) -> Data?
    
    func didLoadView()
    func didSelectDish(with item: Dish)
}

protocol CoffeeShopDetailScreenInteractorInput: AnyObject {
    func loadItems()
}

protocol CoffeeShopDetailScreenInteractorOutput: AnyObject {
    
}

protocol CoffeeShopDetailScreenRouterInput: AnyObject {
    func showDetailDish(output: DishConfiguratorModuleOutput, with item: Dish)
}
