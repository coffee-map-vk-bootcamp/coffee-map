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
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? UIWindowSceneDelegate else {
            return
        }

        let newRootController = MainTabBarController()
        UIView.transition(with: newRootController.view, duration: 0.3, options: .transitionCrossDissolve) {
            sceneDelegate.window??.rootViewController = newRootController
        }
    }
}
