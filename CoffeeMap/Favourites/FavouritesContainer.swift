//
//  FavouritesContainer.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import UIKit

final class FavouritesContainer {
    let input: FavouritesModuleInput
    let viewController: UIViewController
    private(set) weak var router: FavouritesRouterInput!
    
    class func assemble(with context: FavouritesContext) -> FavouritesContainer {
        let router = FavouritesRouter()
        let interactor = FavouritesInteractor()
        let presenter = FavouritesPresenter(router: router, interactor: interactor)
        let viewController = ShopListViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return FavouritesContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: FavouritesModuleInput, router: FavouritesRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct FavouritesContext {
    weak var moduleOutput: FavouritesModuleOutput?
}
