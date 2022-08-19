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
}

extension HomeScreenInteractor: HomeScreenInteractorInput {
    func fetchCoffeeShops() {
        FBService().addCoffeeShopsSubscription { [weak self] result in
            switch result {
            case .success(let shops):
                self?.output?.getShops(shops)
            case .failure(let  error):
                print(error)
            }
        }
    }
}
