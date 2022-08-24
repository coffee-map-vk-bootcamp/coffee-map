//
//  ShoppingCartManager.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 23.08.2022.
//

import Foundation
import UIKit

protocol CartManagerDescription: AnyObject {
    var dishesArray: [OrderDish] { get }

    var price: Int { get }

    var coffeeShopName: String { get set }

    func addDishToOrder(_ dish: OrderDish)

    func deleteDishFromOrder(at index: Int)

    func makeOrder(time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

class ShoppingCartManager: CartManagerDescription {
    var coffeeShopName: String = ""

    static let shared = ShoppingCartManager()

    private let networkService = FBService()

    private(set) var dishesArray: [OrderDish] = [] {
        didSet {
            price = dishesArray.reduce(0, { partialResult, newDish in
                return partialResult + (newDish.count * newDish.price)
            })

            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                  let item = sceneDelegate.window??.rootViewController?.tabBarController?.tabBar.items?[1]
            else {
                return
            }

            if dishesArray.count > 0 {
                item.badgeValue = "\(dishesArray.count)"
            } else {
                item.badgeValue = nil
            }
        }
    }

    private(set) var price = 0

    private init() {}

    func addDishToOrder(_ dish: OrderDish) {
        dishesArray.append(dish)
    }

    func deleteDishFromOrder(at index: Int) {
        dishesArray.remove(at: index)
    }

    func makeOrder(time: Date, completion: @escaping (Result<Void, Error>) -> Void ) {
        let order = Order(name: coffeeShopName, totalPrice: price, date: Int(time.timeIntervalSince1970), dishes: dishesArray)
        networkService.createOrder(with: order) { [weak self] result in
            self?.dishesArray = []
            self?.coffeeShopName = ""
            completion(result)
        }
    }
}
