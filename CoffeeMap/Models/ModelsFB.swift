//
//  ModelsFB.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//

import Foundation

struct DishNW: Decodable {
    let name: String
    let price: Int
    let image: String
    let count: Int
}

struct CoffeeShopNW: Decodable {
    let name: String
    let address: String
    let dishes: [String]
    let image: String
    let latitude: Double
    let longitude: Double
}

struct OrderNW: Decodable {
    let totalPrice: Int
    let dishes: [String]
}

struct UserNW: Decodable {
    let name: String
    let favoriteCoffeeShops: [String]
    let orders: [String]
}
