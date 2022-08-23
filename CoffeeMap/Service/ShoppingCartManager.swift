//
//  ShoppingCartManager.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 23.08.2022.
//

import Foundation

protocol CartManagerDescription {
    var price: Int { get }

    func addDishToOrder(_ dish: OrderDish)

    func deleteDishFromOrder(at index: Int)

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

class ShoppingCartManager: CartManagerDescription {
    static let shared = ShoppingCartManager()

    private let networkService = FBService()

    private var dishesArray: [OrderDish] = [] {
        didSet {
            price = dishesArray.reduce(0, { partialResult, newDish in
                return partialResult + (newDish.count * newDish.price)
            })
        }
    }

    private(set) var price = 0

    private init() {
    }

    func addDishToOrder(_ dish: OrderDish) {
        dishesArray.append(dish)
    }

    func deleteDishFromOrder(at index: Int) {
        dishesArray.remove(at: index)
    }

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void ) {
        let order = Order(name: name, totalPrice: price, date: time, dishes: dishesArray)
        networkService.createOrder(with: order) { result in
            completion(result)
        }
    }
}
