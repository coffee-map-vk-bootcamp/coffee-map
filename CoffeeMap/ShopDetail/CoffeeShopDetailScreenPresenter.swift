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
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenModuleInput {
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenViewOutput {
    func removeFromFavorites() {
        interactor.removeFromFavorites()
    }
    
    func getCoffeeShop() -> CoffeeShop {
        return interactor.getCoffeeShop()
    }
    
    func item(at index: Int) -> DishSection {
        return sections[index]
    }
    
    func number(of section: Int) -> Int {
        return sections[section].dishes.count
    }
    
    func didLoadView() {
        sections = interactor.loadItems()
        interactor.checkIsFavorite()
    }
    
    var count: Int {
        return sections.count
    }
    
    func item(at section: Int, with index: Int) -> Dish {
        return sections[section].dishes[index]
    }
    
    func didSelectDish(with item: Dish) {
        router.showDetailDish(output: self, with: item, coffeeShopName: getCoffeeShop().name)
    }
    
    func checkIsFavorite() {
        interactor.checkIsFavorite()
    }
    
    func addToFavorites() {
        interactor.addToFavorites()
    }
}

extension CoffeeShopDetailScreenPresenter: CoffeeShopDetailScreenInteractorOutput {
    func setFavoriteCoffeeShops(_ coffeeShops: [CoffeeShop]) {
        view?.setFavoriteCoffeeShops(coffeeShops)
    }
}

extension CoffeeShopDetailScreenPresenter: DishConfiguratorModuleOutput {
    func didFinishConfiguration() {
        router.showAlert()
    }
    
    func finishConfigure() {
        
    }
}
