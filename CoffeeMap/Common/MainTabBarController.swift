//
//  MainTabBarController.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 09.08.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        let homeScreen = UINavigationController(rootViewController: UIViewController())
        homeScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.home), tag: 0)

        let cartScreen = UINavigationController(rootViewController: UIViewController())
        cartScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.shoppingCart), tag: 0)

        let favouriteScreen = UINavigationController(rootViewController: UIViewController())
        favouriteScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.favorite), tag: 0)

        let profileContext = ProfileContext(moduleOutput: nil)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        let profileScreen = UINavigationController(rootViewController: profileContainer.viewController)
        profileScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.persone), tag: 0)

        viewControllers = [homeScreen, cartScreen, favouriteScreen, profileScreen]
        view.backgroundColor = .white
    }
}
