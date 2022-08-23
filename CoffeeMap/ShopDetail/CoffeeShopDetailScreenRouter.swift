//
//  CoffeeShopDetailScreenRouter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import UIKit

final class CoffeeShopDetailScreenRouter {
    weak var viewController: UIViewController?
}

extension CoffeeShopDetailScreenRouter: CoffeeShopDetailScreenRouterInput {
    func showDetailDish(output: DishConfiguratorModuleOutput, with item: Dish) {
        print("[DEBUG] Data for \(item.name)")
        
        let context = DishConfiguratorContext(moduleOutput: output, dish: item)
        let dishConfiguratorViewController = DishConfiguratorContainer.assemble(with: context).viewController
        viewController?.parent?.add(dishConfiguratorViewController)
//        viewController?.present(dishConfiguratorViewController, animated: true)
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "You can change the thing", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        
        viewController?.present(alertController, animated: true)
    }
}
