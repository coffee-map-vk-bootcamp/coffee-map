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
    func addDishToOrder(_ dish: Dish, amount: Int, price: Int) {
        let orderDish = OrderDish(name: dish.name, price: price, image: dish.image, count: amount)
        interactor.addDishToOrder(orderDish)
    }

    var dishesArray: [OrderDish] {
        interactor.dishesArray
    }

    func didTapClose() {
        view?.dismiss()
    }
    
    func didLoadView() {
        let dish = interactor.loadDish()
        view?.configureWith(dish: dish)
    }
}

extension DishConfiguratorPresenter: DishConfiguratorInteractorOutput {
}
