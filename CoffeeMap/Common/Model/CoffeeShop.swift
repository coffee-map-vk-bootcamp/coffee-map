//
//  CoffeeShop.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import Foundation

struct CoffeeShop: Codable {
    let id: Int
    let name: String
    
    let image: Data?
    
    let address: Coordinates
    let drinks: [Dish]
    let dishes: [Dish]
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}
