//
//  CoffeeShopDetailScreenInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation

final class CoffeeShopDetailScreenInteractor {
    weak var output: CoffeeShopDetailScreenInteractorOutput?
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func loadItems() {
        print("[DEBUG] MOCK Load Data")
    }
    
}
