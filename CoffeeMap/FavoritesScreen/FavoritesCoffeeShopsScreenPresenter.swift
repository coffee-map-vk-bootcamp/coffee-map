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
    
    private(set) var favoriteShops = [CoffeeShop]()
    
    func deleteFavoriteShop(_ index: Int) {
        favoriteShops.remove(at: index)
    }
    
    init(router: FavoritesCoffeeShopsScreenRouterInput, interactor: FavoritesCoffeeShopsScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenModuleInput {
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenViewOutput {
    func getCoffeeShops() -> [CoffeeShop] {
        return favoriteShops
    }
    
    func remove(at index: Int) {
        favoriteShops.remove(at: index)
        
    }
    
    func getFavoritesCoffeeShops() {
        interactor.fetchCoffeeShops()
    }
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenInteractorOutput {
    func getShops(_ shops: [CoffeeShop]) {
        favoriteShops = shops
        view?.setCoffeeShops(favoriteShops)
    }
}
