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
    
    private lazy var bounceAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.xy")
        animation.values = [0.8, 0.5, 0.9, 1.1, 1.0]
        animation.duration = TimeInterval(0.3)

        return animation
    }()

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let imageView = item.value(forKey: "view") as? UIView else {
            return
        }

        imageView.layer.add(bounceAnimation, forKey: nil)
    }

    private func configure() {
        setupAppearance()
        
        let homeScreenContext = HomeScreenContext(moduleOutput: nil)
        let homeScreenViewController = HomeScreenContainer.assemble(with: homeScreenContext).viewController
        let homeScreen = UINavigationController(rootViewController: homeScreenViewController)
        homeScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.home), tag: 0)
        
        let cartScreenContext = CartScreenContext()
        let cartScreenViewController = CartScreenContainer.assemble(with: cartScreenContext).viewController
        let cartScreen = UINavigationController(rootViewController: cartScreenViewController)
        cartScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.shoppingCart), tag: 0)

        let context = FavoritesCoffeeShopsScreenContext(moduleOutput: nil)
        let favouritesViewController = FavoritesCoffeeShopsScreenContainer.assemble(with: context).viewController

        let favouriteScreen = UINavigationController(rootViewController: favouritesViewController)
        favouriteScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.favorite), tag: 0)

        let profileContext = ProfileContext(moduleOutput: nil)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        let profileScreen = UINavigationController(rootViewController: profileContainer.viewController)
        profileScreen.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageNames.persone), tag: 0)

        viewControllers = [homeScreen, cartScreen, favouriteScreen, profileScreen]
        view.backgroundColor = .systemBackground
    }
    
    private func setupAppearance() {
        UITabBar.appearance().backgroundColor = .systemBackground
    }
}
