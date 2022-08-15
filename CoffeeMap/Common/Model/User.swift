//
//  User.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import Foundation

struct User {
    let id: Int
    let firstName: String
    let lastName: String
    
    let image: Data?
    let orders: [Order]
}
