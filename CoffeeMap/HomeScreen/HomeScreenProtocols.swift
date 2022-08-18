//
//  HomeScreenProtocols.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import Foundation
import CoreLocation

protocol HomeScreenModuleInput {
    var moduleOutput: HomeScreenModuleOutput? { get }
}

protocol HomeScreenModuleOutput: AnyObject {
}

protocol HomeScreenViewInput: AnyObject {
    func showLocations(_ coffeeShops: [CoffeeShop])
}

protocol HomeScreenViewOutput: AnyObject {
    func didLoadView()
    func openDetail(with: CoffeeShop)
}

protocol HomeScreenInteractorInput: AnyObject {
    func fetchCoffeeShops()
}

protocol HomeScreenInteractorOutput: AnyObject {
    func getShops(_ shops: [CoffeeShop])
}

protocol HomeScreenRouterInput: AnyObject {
    func showDetail(with: CoffeeShop)
}
