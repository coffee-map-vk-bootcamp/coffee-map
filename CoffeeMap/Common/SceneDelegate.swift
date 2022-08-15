//
//  SceneDelegate.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 09.08.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let context = LoginContext()
        
        if Auth.auth().currentUser != nil {
            window?.rootViewController = MainTabBarController()
        } else {
            window?.rootViewController = LoginContainer.assemble(with: context).viewController
        }
        
        window?.makeKeyAndVisible()
    }

}
