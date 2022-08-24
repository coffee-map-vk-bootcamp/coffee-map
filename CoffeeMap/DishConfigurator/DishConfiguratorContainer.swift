//
//  DishConfiguratorContainer.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 12.08.2022.
//  
//

import UIKit

final class DishConfiguratorContainer {
    let input: DishConfiguratorModuleInput
    let viewController: UIViewController
    private(set) weak var router: DishConfiguratorRouterInput!
    
    class func assemble(with context: DishConfiguratorContext) -> DishConfiguratorContainer {
        let router = DishConfiguratorRouter()
        let interactor = DishConfiguratorInteractor(cartManager: ShoppingCartManager.shared)
        let presenter = DishConfiguratorPresenter(router: router, interactor: interactor)
        let viewController = DishConfiguratorViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.setDish(dish: context.dish)
        interactor.output = presenter
        
        return DishConfiguratorContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: DishConfiguratorModuleInput, router: DishConfiguratorRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct DishConfiguratorContext {
    weak var moduleOutput: DishConfiguratorModuleOutput?
    let dish: Dish
}
