//
//  FavouritesPresenter.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import Foundation

final class FavouritesPresenter {
    
    weak var view: FavouritesViewInput?
    weak var moduleOutput: FavouritesModuleOutput?
    
    private let router: FavouritesRouterInput
    private let interactor: FavouritesInteractorInput
    
    init(router: FavouritesRouterInput, interactor: FavouritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavouritesPresenter: FavouritesModuleInput {
}

extension FavouritesPresenter: FavouritesViewOutput {
}

extension FavouritesPresenter: FavouritesInteractorOutput {
}
