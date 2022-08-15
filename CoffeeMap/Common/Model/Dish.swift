//
//  Dish.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import Foundation

struct Dish: Codable {
    let id: Int
    let name: String
    let price: Int
    let size: DishSize
    
    let image: Data?
}

enum DishSize: Codable {
    case small, medium, large
}
