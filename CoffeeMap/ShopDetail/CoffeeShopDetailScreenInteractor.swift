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
        let drinksSection = DishSection(sectionTitle: "Drinks", dishes: coffeeShop.drinks)
        let dishSection = DishSection(sectionTitle: "Dishes", dishes: coffeeShop.dishes)
        
        var totalSections: [DishSection] = []
        if drinksSection.dishes.count > 0 {
            totalSections.append(drinksSection)
        }
        
        if dishSection.dishes.count > 0 {
            totalSections.append(dishSection)
        }
        
        sections = totalSections
    }
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func getCoffeeShop() -> CoffeeShop {
        return coffeeShop ?? .init()
    }
    
    func loadItems() -> [DishSection] {
        return sections
    }
}
