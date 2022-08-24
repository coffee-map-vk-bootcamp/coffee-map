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
    var dish: Dish?
    
    func setDish(dish: Dish) {
        self.dish = dish
    }
}

extension DishConfiguratorInteractor: DishConfiguratorInteractorInput {
    func loadDish() -> Dish {
        return dish ?? .init()
    }
}
