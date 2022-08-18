//
//  FavoritesCoffeeShopsScreenContainer.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import UIKit

final class FavoritesCoffeeShopsScreenContainer {
    let input: FavoritesCoffeeShopsScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: FavoritesCoffeeShopsScreenRouterInput!
    
    class func assemble(with context: FavoritesCoffeeShopsScreenContext) -> FavoritesCoffeeShopsScreenContainer {
        let router = FavoritesCoffeeShopsScreenRouter()
        let interactor = FavoritesCoffeeShopsScreenInteractor()
        let presenter = FavoritesCoffeeShopsScreenPresenter(router: router, interactor: interactor)
        let viewController = FavoritesCoffeeShopsScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return FavoritesCoffeeShopsScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: FavoritesCoffeeShopsScreenModuleInput, router: FavoritesCoffeeShopsScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct FavoritesCoffeeShopsScreenContext {
    weak var moduleOutput: FavoritesCoffeeShopsScreenModuleOutput?
}
