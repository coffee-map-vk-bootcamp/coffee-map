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
}

protocol DishConfiguratorViewInput: AnyObject {
}

protocol DishConfiguratorViewOutput: AnyObject {
}

protocol DishConfiguratorInteractorInput: AnyObject {
}

protocol DishConfiguratorInteractorOutput: AnyObject {
}

protocol DishConfiguratorRouterInput: AnyObject {
}
