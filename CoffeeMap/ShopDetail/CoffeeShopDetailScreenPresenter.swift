//
//  CoffeeShopDetailScreenPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation

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
                .init(id: 0, name: "Coffee", price: 1235, size: .medium, image: nil),
                .init(id: 0, name: "Baton", price: 1235, size: .medium, image: nil),
                .init(id: 0, name: "Tea", price: 1235, size: .medium, image: nil),
                .init(id: 0, name: "Pepsi", price: 1235, size: .medium, image: nil),
                .init(id: 0, name: "Water", price: 1235, size: .medium, image: nil)
            ]),
            .init(sectionTitle: "Drinks", headerImageURL: "", dishes: [
                .init(id: 0, name: "Coffee", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Baton", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Tea", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Pepsi", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Water", price: 222, size: .medium, image: nil)
            ]),
            .init(sectionTitle: "Water Food", headerImageURL: "", dishes: [
                .init(id: 0, name: "Coffee", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Baton", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Tea", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Pepsi", price: 222, size: .medium, image: nil),
                .init(id: 0, name: "Water", price: 222, size: .medium, image: nil)
            ])
        ]
        
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenModuleInput {
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenViewOutput {
    func didLoadView() {
        interactor.loadItems()
    }
    
    func image(at url: String) -> Data? {
        return nil
    }
    
    var count: Int {
        return sections.count
    }
    
    func item(at index: Int) -> DishSection {
        return sections[index]
    }
    
    func didSelectDish(with item: Dish) {
        router.showDetailDish(output: self, with: item)
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenInteractorOutput {
    
}

extension CoffeeShopDetailScreenPresenter: DishConfiguratorModuleOutput {
    
}
