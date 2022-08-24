//
//  HomeScreenContainer.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import UIKit

final class HomeScreenContainer {
    let input: HomeScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: HomeScreenRouterInput!
    
    class func assemble(with context: HomeScreenContext) -> HomeScreenContainer {
        let router = HomeScreenRouter()
        let interactor = HomeScreenInteractor(networkManager: FBService())
        let presenter = HomeScreenPresenter(router: router, interactor: interactor)
        let viewController = HomeScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        interactor.output = presenter
        
        return HomeScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: HomeScreenModuleInput, router: HomeScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct HomeScreenContext {
    weak var moduleOutput: HomeScreenModuleOutput?
}
