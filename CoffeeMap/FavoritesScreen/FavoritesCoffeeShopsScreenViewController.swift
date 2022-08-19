//
//  FavoritesCoffeeShopsScreenViewController.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import UIKit

final class FavoritesCoffeeShopsScreenViewController: UIViewController {
    private let output: FavoritesCoffeeShopsScreenViewOutput
    
    private lazy var childViewController = ShopListViewController()

    init(output: FavoritesCoffeeShopsScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Любимые кофейни"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        childViewController.delegate = self
        add(childViewController)
    }
}

extension FavoritesCoffeeShopsScreenViewController: FavoritesCoffeeShopsScreenViewInput {
    func setCoffeeShops(_ shops: [CoffeeShop]) {
        childViewController.configure(with: shops)
    }
}

extension FavoritesCoffeeShopsScreenViewController: ShopListViewControllerDelegate {
    func getCoffeeShops() {
        output.getFavoritesCoffeeShops()
    }
}
