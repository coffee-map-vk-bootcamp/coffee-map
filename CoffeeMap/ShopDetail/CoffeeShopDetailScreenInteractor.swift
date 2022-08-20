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
    
    private var sections = [DishSection]()
    private var coffeeShop: CoffeeShop?
    
    func setCoffeeShop(_ coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        let section = DishSection(sectionTitle: "Drinks", dishes: coffeeShop.dishes)
        sections.append(section)
    }
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func getCoffeeShopImage() -> String {
        return coffeeShop?.image ?? ""
    }
    
    func loadItems() -> [DishSection] {
        return sections
    }
}
