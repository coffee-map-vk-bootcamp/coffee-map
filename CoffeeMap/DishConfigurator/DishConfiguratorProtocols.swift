//
//  DishConfiguratorProtocols.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 12.08.2022.
//  
//

import Foundation

protocol DishConfiguratorModuleInput {
    var moduleOutput: DishConfiguratorModuleOutput? { get }
}

protocol DishConfiguratorModuleOutput: AnyObject {
    func didFinishConfiguration()
}

protocol DishConfiguratorViewInput: AnyObject {
    func dismiss()
    func setDish(_ dish: Dish)
}

protocol DishConfiguratorViewOutput: AnyObject {
    func didLoadView()
    func didTapClose()

    var dishesArray: [OrderDish] { get }

    func addDishToOrder(_ dish: OrderDish)

    func startConfigureOrder(in coffeeShop: String)
}

protocol DishConfiguratorInteractorInput: AnyObject {
    func loadDish() -> Dish

    var dishesArray: [OrderDish] { get }

    func addDishToOrder(_ dish: OrderDish)

    func startConfigureOrder(in coffeeShop: String)

}

protocol DishConfiguratorInteractorOutput: AnyObject {
}

protocol DishConfiguratorRouterInput: AnyObject {
}
