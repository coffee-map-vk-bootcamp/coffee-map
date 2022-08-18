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
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func loadItems() -> [DishSection] {
        print("[DEBUG] MOCK Load Data")
        
        sections = [
            .init(sectionTitle: "Suck my Dick", dishes: [
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
            ]),
            .init(sectionTitle: "Suck my Dick", dishes: [
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
            ]),
            .init(sectionTitle: "Suck my Dick", dishes: [
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
                .init(name: "Coffee", price: 100991, image: "", count: 2),
            ])
        ]
        
        return sections
    }
}
