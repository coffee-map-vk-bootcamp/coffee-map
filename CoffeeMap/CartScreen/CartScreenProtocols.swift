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
    var dishList: [OrderDish] { get }

    var price: Int { get }

    var coffeeShopName: String { get }

    func startConfigureOrder(in coffeeShop: String)

    func deleteDishFromOrder(at index: Int)

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CartScreenInteractorInput: AnyObject {
    var dishList: [OrderDish] { get }

    var price: Int { get }

    var coffeeShopName: String { get }

    func startConfigureOrder(in coffeeShop: String)

    func deleteDishFromOrder(at index: Int)

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CartScreenInteractorOutput: AnyObject {
}

protocol CartScreenRouterInput: AnyObject {
}

