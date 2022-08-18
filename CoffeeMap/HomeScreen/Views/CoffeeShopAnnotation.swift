//
//  CoffeeShopAnnotation.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//

import Foundation
import MapKit

final class CoffeeShopAnnotation: MKPointAnnotation {
    var coffeeShop: CoffeeShop?
    
    func configure(with coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
    }
}
