//
//  ShoppingCartService.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 23.08.2022.
//

import Foundation

protocol ShoppingCartServiceProtocol {
    var price: Int { get }

    func addDishToOrder(_ dish: OrderDish)

    func deleteDishFromOrder(at index: Int)

    func makeOrder(name: String, time: Date)
}

class ShoppingCartService: ShoppingCartServiceProtocol {
    static let shared = ShoppingCartService()

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

    func makeOrder(name: String, time: Date) {
        let order = Order(name: name, totalPrice: price, date: time, dishes: dishesArray)
    }
}
