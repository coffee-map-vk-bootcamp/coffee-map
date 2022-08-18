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

struct CoffeeShop: Decodable {
    let name: String
    let address: String
    let dishes: [Dish]
    let image: String
    let latitude: Double
    let longitude: Double
}

struct Order: Decodable {
    let totalPrice: Int
    let dishes: [String: [Dish]]
}

struct User: Decodable {
    let name: String
    let favoriteCoffeeShops: [CoffeeShop]
    let orders: [String]
}
