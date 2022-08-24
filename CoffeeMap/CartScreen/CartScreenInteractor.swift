//
//  CartScreenInteractor.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import Foundation

final class CartScreenInteractor {
    weak var output: CartScreenInteractorOutput?

    private let cartManager: CartManagerDescription

    init(cartManager: CartManagerDescription) {
        self.cartManager = cartManager
    }
}

extension CartScreenInteractor: CartScreenInteractorInput {
    var coffeeShopName: String {
        cartManager.coffeeShopName
    }

    var dishList: [OrderDish] {
        cartManager.dishesArray
    }

    var price: Int {
        cartManager.price
    }

    func deleteDishFromOrder(at index: Int) {
        cartManager.deleteDishFromOrder(at: index)
    }

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void) {
        cartManager.makeOrder(name: name, time: time, completion: completion)
    }
}
