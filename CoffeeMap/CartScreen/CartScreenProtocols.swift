//
//  CartScreenProtocols.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import Foundation

protocol CartScreenModuleInput {
    var moduleOutput: CartScreenModuleOutput? { get }
}

protocol CartScreenModuleOutput: AnyObject {
}

protocol CartScreenViewInput: AnyObject {
}

protocol CartScreenViewOutput: AnyObject {
    func getOrder() -> CartList
}

protocol CartScreenInteractorInput: AnyObject {
}

protocol CartScreenInteractorOutput: AnyObject {
}

protocol CartScreenRouterInput: AnyObject {
}
