//
//  CoffeeShopDetailScreenContainer.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import UIKit

final class CoffeeShopDetailScreenContainer {
    let input: CoffeeShopDetailScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: CoffeeShopDetailScreenRouterInput!
    
    class func assemble(with context: CoffeeShopDetailScreenContext) -> CoffeeShopDetailScreenContainer {
        let router = CoffeeShopDetailScreenRouter()
        let interactor = CoffeeShopDetailScreenInteractor()
        let presenter = CoffeeShopDetailScreenPresenter(router: router, interactor: interactor)
        let viewController = CoffeeShopDetailScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        interactor.output = presenter
        interactor.setCoffeeShop(context.coffeeShop)
        
        return CoffeeShopDetailScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: CoffeeShopDetailScreenModuleInput, router: CoffeeShopDetailScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CoffeeShopDetailScreenContext {
    weak var moduleOutput: CoffeeShopDetailScreenModuleOutput?
    let coffeeShop: CoffeeShop
}
