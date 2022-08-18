//
//  UINavigationBar+Ext.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//

import UIKit

extension UINavigationController {
    func configureBar(with imageView: UIImageView) {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationItem.titleView = imageView
        navigationBar.backgroundColor = .clear
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
