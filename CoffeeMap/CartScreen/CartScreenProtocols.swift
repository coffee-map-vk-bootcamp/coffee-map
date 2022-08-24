//
//  CartScreenProtocols.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import Foundation

protocol CartScreenModuleInput {
    var moduleOutput: CartScreenModuleOutput? { get }
}

protocol CartScreenModuleOutput: AnyObject {
}

protocol CartScreenViewInput: AnyObject {
}

protocol CartScreenViewOutput: AnyObject {
    var coffeeShopName: String { get }

    var dishList: [OrderDish] { get }

    var price: Int { get }

    func deleteDishFromOrder(at index: Int)

    func makeOrder(time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CartScreenInteractorInput: AnyObject {
    var coffeeShopName: String { get }

    var dishList: [OrderDish] { get }

    var price: Int { get }

    func deleteDishFromOrder(at index: Int)

    func makeOrder(time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CartScreenInteractorOutput: AnyObject {
}

protocol CartScreenRouterInput: AnyObject {
}
