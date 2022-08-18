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
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: 100, height: 50))
        button.backgroundColor = .gray
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.center = view.center
        
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
        output.didCloseView()
    }
}
