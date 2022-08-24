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
    func configureWith(dish: Dish)
}

protocol DishConfiguratorViewOutput: AnyObject {
    func didLoadView()
    func didTapClose()

    var dishesArray: [OrderDish] { get }

    func addDishToOrder(_ dish: Dish, amount: Int, price: Int)
}

protocol DishConfiguratorInteractorInput: AnyObject {
    func loadDish() -> Dish

    var dishesArray: [OrderDish] { get }

    func addDishToOrder(_ dish: OrderDish)
}

protocol DishConfiguratorInteractorOutput: AnyObject {
}

protocol DishConfiguratorRouterInput: AnyObject {
}
