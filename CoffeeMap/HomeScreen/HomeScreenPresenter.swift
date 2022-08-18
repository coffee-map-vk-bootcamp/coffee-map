//
//  HomeScreenPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import Foundation
import CoreLocation

final class HomeScreenPresenter {
    weak var view: HomeScreenViewInput?
    weak var moduleOutput: HomeScreenModuleOutput?
    
    private let router: HomeScreenRouterInput
    private let interactor: HomeScreenInteractorInput
    
    var coffeeShops = [CoffeeShop]()
    
    init(router: HomeScreenRouterInput, interactor: HomeScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HomeScreenPresenter: HomeScreenModuleInput {
}

extension HomeScreenPresenter: HomeScreenViewOutput {
    func openDetail(with coffeeShop: CoffeeShop) {
        router.showDetail(with: coffeeShop)
    }
    
    func didLoadView() {
        interactor.fetchCoffeeShops()
    }
    
    func getCoffeeShops() -> [CoffeeShop] {
        return coffeeShops
    }
}

extension HomeScreenPresenter: HomeScreenInteractorOutput {
    func getShops(_ shops: [CoffeeShop]) {
        coffeeShops = shops
        view?.showLocations(shops)
    }
}

private extension HomeScreenPresenter {
   
}
