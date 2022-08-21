//
//  FBError.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 20.08.2022.
//

import Foundation

enum FirebaseError: Error {
    case userNotLogin
    case userNotFound
    case receivedNilData
    case dataParseError
    case coffeeShopNotFound
}
