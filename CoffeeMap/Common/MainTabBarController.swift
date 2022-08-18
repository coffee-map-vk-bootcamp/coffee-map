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
        setupAppearance()
        
        let homeScreenContext = HomeScreenContext(moduleOutput: nil)
        let homeScreenViewController = HomeScreenContainer.assemble(with: homeScreenContext).viewController
        let homeScreen = UINavigationController(rootViewController: homeScreenViewController)
        homeScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.home), tag: 0)

        let cartScreen = UINavigationController(rootViewController: UIViewController())
        cartScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.shoppingCart), tag: 0)

        let favouriteScreen = UINavigationController(rootViewController: UIViewController())
        favouriteScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.favorite), tag: 0)

        let profileScreen = UINavigationController(rootViewController: UIViewController())
        profileScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.persone), tag: 0)

        viewControllers = [homeScreen, cartScreen, favouriteScreen, profileScreen]
        view.backgroundColor = .white
    }
    
    private func setupAppearance() {
        UITabBar.appearance().backgroundColor = .systemBackground
    }
}
