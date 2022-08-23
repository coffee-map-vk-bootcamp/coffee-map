//
//  HomeScreenRouter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import UIKit
import UBottomSheet

final class HomeScreenRouter {
    weak var viewController: UIViewController?
}

extension HomeScreenRouter: HomeScreenRouterInput {
    func showDetail(with coffeeShop: CoffeeShop) {
        guard let homeViewController = viewController as? HomeScreenViewController else { return }
        
        let shopDetailContext = CoffeeShopDetailScreenContext(moduleOutput: nil, coffeeShop: coffeeShop)
        
        guard let shopDetailViewController = CoffeeShopDetailScreenContainer.assemble(
            with: shopDetailContext
        ).viewController as? CoffeeShopDetailScreenViewController else { return }
        
        homeViewController.dataSource = CoffeeShopBottomSheetDataSource()
        homeViewController.sheetVC = shopDetailViewController
        
        homeViewController.startShowingBottomSheet()
    }
}
