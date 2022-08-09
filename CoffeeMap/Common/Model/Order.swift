//
//  Order.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import Foundation

struct Order {
    let id: Int
    let dishes: [Dish]
    let totalPrice: Int
    let time: Int
}
