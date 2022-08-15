//
//  Models.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 14.08.2022.
//

import Foundation

struct Dish: Decodable {
    let name: String
    let price: Int
    let image: String
    let count: Int
}

struct Coordinates: Decodable {
    let latitude: Float
    let longitude: Float
}

struct CoffeeShop: Decodable {
    let name: String
    let address: String
    let coordinates: Coordinates
    let dishes: [Dish]
    let image: String
    
}

struct Order: Decodable {
    let totalPrice: Int
    let dishes: [Dish]
}

struct User: Decodable {
    let name: String
    let favoriteCoffeeShops: [CoffeeShop]
    let orders: [Order]
}
