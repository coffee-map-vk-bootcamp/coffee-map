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
        FBService.fetchCoffeeShops { [weak output] result in
            switch result {
            case .success(let shops):
                output?.getShops(shops)
            case .failure(let  error):
                print(error)
            }
        }
    }
}
