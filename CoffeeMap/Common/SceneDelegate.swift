//
//  SceneDelegate.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 09.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = MainTabBarController()
        let context = CoffeeShopDetailScreenContext(moduleOutput: nil)
        window?.rootViewController = CoffeeShopDetailScreenContainer.assemble(with: context).viewController
        window?.makeKeyAndVisible()
    }

}
