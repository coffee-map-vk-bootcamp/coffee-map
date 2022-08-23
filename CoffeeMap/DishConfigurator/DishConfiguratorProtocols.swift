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
}

protocol DishConfiguratorInteractorInput: AnyObject {
    func loadDish() -> Dish
}

protocol DishConfiguratorInteractorOutput: AnyObject {
}

protocol DishConfiguratorRouterInput: AnyObject {
}
