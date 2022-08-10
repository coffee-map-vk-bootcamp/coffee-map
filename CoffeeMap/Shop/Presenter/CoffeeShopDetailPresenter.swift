//
//  CoffeeShopDetailPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import Foundation
import UIKit

protocol DetailViewDescription: AnyObject {
    var drinks: [Dish] { get set }
    var dishes: [Dish] { get set }
}

protocol DetailPresenterDescription: AnyObject {
    init(view: DetailViewDescription)
    
    func set(dishes: [Dish], drinks: [Dish])
}

final class CoffeeShopDetailPresenter: DetailPresenterDescription {
    weak var view: DetailViewDescription?
    
    init(view: DetailViewDescription) {
        self.view = view
    }
    
    func set(dishes: [Dish], drinks: [Dish]) {
        view?.dishes = dishes
        view?.drinks = drinks
    }
}

final class DataManager {
    
}
