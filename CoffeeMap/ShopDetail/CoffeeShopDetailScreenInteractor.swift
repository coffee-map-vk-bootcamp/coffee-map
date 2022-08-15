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
            .init(sectionTitle: "Drinks You Might Like", dishes: [
                .init(id: 0, name: "Coffee", price: 1, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Baton", price: 2, size: .medium, image: nil, isSelected: true),
                .init(id: 0, name: "Tea", price: 3, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Pepsi", price: 4, size: .medium, image: nil, isSelected: true),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false)
            ]),
            .init(sectionTitle: "Drinks", dishes: [
                .init(id: 0, name: "Coffee", price: 6, size: .medium, image: nil, isSelected: true),
                .init(id: 0, name: "Baton", price: 7, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Tea", price: 8, size: .medium, image: nil, isSelected: false),
            ]),
            .init(sectionTitle: "Water Food", dishes: [
                .init(id: 0, name: "Coffee", price: 11, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Baton", price: 12, size: .medium, image: nil, isSelected: false),
            ]),
            .init(sectionTitle: "Drinks You Might Like", dishes: [
                .init(id: 0, name: "Coffee", price: 1, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Baton", price: 2, size: .medium, image: nil, isSelected: true),
                .init(id: 0, name: "Tea", price: 3, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Pepsi", price: 4, size: .medium, image: nil, isSelected: true),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false),
                .init(id: 0, name: "Water", price: 5, size: .medium, image: nil, isSelected: false)
            ])
        ]
        
        return sections
    }
}
