//
//  DishConfiguratorInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 12.08.2022.
//  
//

import Foundation

final class DishConfiguratorInteractor {
    weak var output: DishConfiguratorInteractorOutput?

    private let cartManager: CartManagerDescription

    var dish: Dish?
    
    func setDish(dish: Dish) {
        self.dish = dish
    }

    init(cartManager: CartManagerDescription) {
        self.cartManager = cartManager
    }
}

extension DishConfiguratorInteractor: DishConfiguratorInteractorInput {
    var dishesArray: [OrderDish] {
        cartManager.dishesArray
    }

    func startConfigureOrder(in coffeeShop: String) {
        cartManager.startConfigureOrder(in: coffeeShop)
    }

    func loadDish() -> Dish {
        return dish ?? .init()
    }

    func addDishToOrder(_ dish: OrderDish) {
        cartManager.addDishToOrder(dish)
    }
}
