//
//  HomeScreenInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import Foundation

final class HomeScreenInteractor {
    weak var output: HomeScreenInteractorOutput?

    private let networkManager: NetworkManagerDescription

    init(networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension HomeScreenInteractor: HomeScreenInteractorInput {
    func fetchCoffeeShops() {
        networkManager.addCoffeeShopsSubscription { [weak self] result in
            switch result {
            case .success(let shops):
                self?.output?.getShops(shops)
            case .failure(let  error):
                print(error)
            }
        }
    }
}
