//
//  FavoritesCoffeeShopsScreenPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import Foundation

final class FavoritesCoffeeShopsScreenPresenter {
    weak var view: FavoritesCoffeeShopsScreenViewInput?
    weak var moduleOutput: FavoritesCoffeeShopsScreenModuleOutput?
    
    private let router: FavoritesCoffeeShopsScreenRouterInput
    private let interactor: FavoritesCoffeeShopsScreenInteractorInput
    
    init(router: FavoritesCoffeeShopsScreenRouterInput, interactor: FavoritesCoffeeShopsScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenModuleInput {
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenViewOutput {
    func getFavoritesCoffeeShops() {
        interactor.obtainCoffeeShops()
    }
    
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenInteractorOutput {
    func transferCoffeeShops(_ shops: [CoffeeShop]) {
        view?.setCoffeeShops(shops)
    }
}
