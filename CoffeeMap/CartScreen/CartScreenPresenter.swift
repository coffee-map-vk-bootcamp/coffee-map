//
//  CartScreenPresenter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import Foundation

final class CartScreenPresenter {
    weak var view: CartScreenViewInput?
    weak var moduleOutput: CartScreenModuleOutput?
    
    private let router: CartScreenRouterInput
    private let interactor: CartScreenInteractorInput
    
    init(router: CartScreenRouterInput, interactor: CartScreenInteractorInput, cartList: CartList) {
        self.router = router
        self.interactor = interactor
    }
}

extension CartScreenPresenter: CartScreenModuleInput {
}

extension CartScreenPresenter: CartScreenViewOutput {
    var coffeeShopName: String {
        interactor.coffeeShopName
    }
    
    var price: Int {
        interactor.price
    }

    func deleteDishFromOrder(at index: Int) {
        interactor.deleteDishFromOrder(at: index)
    }

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void) {
        interactor.makeOrder(name: name, time: time, completion: completion)
    }

    var dishList: [OrderDish] {
        interactor.dishList
    }
}

extension CartScreenPresenter: CartScreenInteractorOutput {
}
