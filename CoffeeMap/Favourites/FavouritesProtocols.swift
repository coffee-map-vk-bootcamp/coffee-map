//
//  FavouritesProtocols.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import Foundation

protocol FavouritesModuleInput {
    var moduleOutput: FavouritesModuleOutput? { get }
}

protocol FavouritesModuleOutput: AnyObject {
}

protocol FavouritesViewInput: AnyObject {
}

protocol FavouritesViewOutput: AnyObject {
}

protocol FavouritesInteractorInput: AnyObject {
}

protocol FavouritesInteractorOutput: AnyObject {
}

protocol FavouritesRouterInput: AnyObject {
}
