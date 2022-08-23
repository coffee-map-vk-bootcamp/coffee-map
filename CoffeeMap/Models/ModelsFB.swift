//
//  ModelsFB.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//

import Foundation

struct Dish: Decodable {
    let name: String
    let price: Int
    let image: String
}

extension Dish {
    init() {
        name = ""
        price = 0
        image = ""
    }
}

struct CoffeeShop: Decodable {
    let id: String
    let name: String
    let address: String
    let dishes: [Dish]
    let drinks: [Dish]
    let image: String
    let latitude: Double
    let longitude: Double
}

extension CoffeeShop {
    init() {
        id = ""
        name = ""
        address = ""
        dishes = []
        drinks = []
        image = ""
        latitude = 0.0
        longitude = 0.0
    }
}

struct Order: Decodable {
    let name: String
    let totalPrice: Int
    let date: Date
    let dishes: [OrderDish]
}

struct OrderDish: Decodable {
    let name: String
    let price: Int
    let image: String
    let count: Int
}

struct User: Decodable {
    let name: String
    let favoriteCoffeeShops: [String]
    let orders: [Order]
    let image: String
}
