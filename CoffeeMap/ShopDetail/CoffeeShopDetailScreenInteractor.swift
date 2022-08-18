//
//  CoffeeShopDetailScreenInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation

final class CoffeeShopDetailScreenInteractor {
    weak var output: CoffeeShopDetailScreenInteractorOutput?
    
    var sections = [DishSection]()
    
    func setCoffeeShop(_ coffeeShop: CoffeeShop) {
        let section = DishSection(sectionTitle: "Drinks", dishes: coffeeShop.dishes)
        sections.append(section)
    }
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func loadItems() -> [DishSection] {
        return sections
    }
}
