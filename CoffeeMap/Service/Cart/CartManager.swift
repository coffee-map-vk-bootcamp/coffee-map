//
//  CartManager.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 23.08.2022.
//

import Foundation

final class CartManager {
    static let shared = CartManager()
    
    private var dishes = [Dish]()
    
    private init() { }
}
