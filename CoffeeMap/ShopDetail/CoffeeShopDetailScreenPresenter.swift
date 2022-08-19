//
//  CoffeeShopDetailScreenPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation
import UIKit

final class CoffeeShopDetailScreenPresenter {
    weak var view: CoffeeShopDetailScreenViewInput?
    weak var moduleOutput: CoffeeShopDetailScreenModuleOutput?
    
    private let router: CoffeeShopDetailScreenRouterInput
    private let interactor: CoffeeShopDetailScreenInteractorInput
    
    private var sections: [DishSection] = []
    
    init(router: CoffeeShopDetailScreenRouterInput, interactor: CoffeeShopDetailScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
        
        sections = [
            .init(sectionTitle: "Drinks You Might Like", headerImageURL: "", dishes: [
                .init(name: "Coffee", price: 1235, image: ""),
                .init(name: "Baton", price: 1235, image: ""),
                .init(name: "Tea", price: 1235, image: ""),
                .init(name: "Pepsi", price: 1235, image: ""),
                .init(name: "Water", price: 1235, image: "")
            ]),
            .init(sectionTitle: "Drinks", headerImageURL: "", dishes: [
                .init(name: "Coffee", price: 222, image: ""),
                .init(name: "Baton", price: 222, image: ""),
                .init(name: "Tea", price: 222, image: ""),
                .init(name: "Pepsi", price: 222, image: ""),
                .init(name: "Water", price: 222, image: "")
            ]),
            .init(sectionTitle: "Water Food", headerImageURL: "", dishes: [
                .init(name: "Coffee", price: 222, image: ""),
                .init(name: "Baton", price: 222, image: ""),
                .init(name: "Tea", price: 222, image: ""),
                .init(name: "Pepsi", price: 222, image: ""),
                .init(name: "Water", price: 222, image: "")
            ])
        ]
        
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenModuleInput {
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenViewOutput {
    func item(at index: Int) -> DishSection {
        return sections[index]
    }
    
    func number(of section: Int) -> Int {
        return sections[section].dishes.count
    }
    
    func didLoadView() {
        sections = interactor.loadItems()
    }
    
    func image(at url: String) -> Data? {
        return nil
    }
    
    var count: Int {
        return sections.count
    }
    
    func item(at section: Int, with index: Int) -> Dish {
        return sections[section].dishes[index]
    }
    
    func didSelectDish(with item: Dish) {
        router.showDetailDish(output: self, with: item)
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenInteractorOutput {
    
}

extension CoffeeShopDetailScreenPresenter: DishConfiguratorModuleOutput {
    func didFinishConfiguration() {
        router.showAlert()
    }
    
    func finishConfigure() {
        
    }
}
