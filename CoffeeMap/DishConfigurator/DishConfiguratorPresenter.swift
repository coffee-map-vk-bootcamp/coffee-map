//
//  DishConfiguratorPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 12.08.2022.
//  
//

import Foundation

final class DishConfiguratorPresenter {
    weak var view: DishConfiguratorViewInput?
    weak var moduleOutput: DishConfiguratorModuleOutput?
    
    private let router: DishConfiguratorRouterInput
    private let interactor: DishConfiguratorInteractorInput
    
    init(router: DishConfiguratorRouterInput, interactor: DishConfiguratorInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DishConfiguratorPresenter: DishConfiguratorModuleInput {
}

extension DishConfiguratorPresenter: DishConfiguratorViewOutput {
}

extension DishConfiguratorPresenter: DishConfiguratorInteractorOutput {
}