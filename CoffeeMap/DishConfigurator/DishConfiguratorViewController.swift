//
//  DishConfiguratorViewController.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 12.08.2022.
//  
//

import UIKit

final class DishConfiguratorViewController: UIViewController {
    private let output: DishConfiguratorViewOutput

    init(output: DishConfiguratorViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension DishConfiguratorViewController: DishConfiguratorViewInput {
}

private extension DishConfiguratorViewController {
    func setup() {
        view.backgroundColor = .systemBackground
    }
}
