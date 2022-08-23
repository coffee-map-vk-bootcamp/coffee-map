//
//  CartScreenContainer.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import UIKit

final class CartScreenContainer {
    let input: CartScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: CartScreenRouterInput!
    
    class func assemble(with context: CartScreenContext) -> CartScreenContainer {
        let router = CartScreenRouter()
        let interactor = CartScreenInteractor()
        let presenter = CartScreenPresenter(router: router, interactor: interactor, cartList: context.cartList ?? CartList())
        let viewController = CartScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return CartScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: CartScreenModuleInput, router: CartScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CartScreenContext {
    weak var moduleOutput: CartScreenModuleOutput?
    weak var cartList: CartList?
}
