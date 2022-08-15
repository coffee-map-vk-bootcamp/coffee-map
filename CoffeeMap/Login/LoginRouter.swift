//
//  LoginRouter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//  
//

import UIKit

final class LoginRouter {
    weak var controller: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func successLogin() {
        controller?.present(MainTabBarController(), animated: true, completion: nil)
    }
}
