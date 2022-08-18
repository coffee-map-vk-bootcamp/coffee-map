//
//  HomeScreenRouter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import UIKit

final class HomeScreenRouter {
    weak var viewController: UIViewController?
}

extension HomeScreenRouter: HomeScreenRouterInput {
    func showDetail(with coffeeShop: CoffeeShop) {
        let shopDetailContext = CoffeeShopDetailScreenContext(moduleOutput: nil, coffeeShop: coffeeShop)
        
        let shopDetailViewController = CoffeeShopDetailScreenContainer.assemble(with: shopDetailContext).viewController
        viewController?.navigationController?.pushViewController(shopDetailViewController, animated: true)
    }   
}
