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
    
    private let alertView = DishConfigurationAlertView()
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    func dismiss() {
        remove()
    }
    
}

private extension DishConfiguratorViewController {
    func setup() {
        view.backgroundColor = .clear
        view.addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.delegate = self
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            alertView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
            alertView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 300)
            
        ])
    }
}

extension DishConfiguratorViewController: DishConfigurationAlertViewDelegate {
    func didTapClose() {
        output.didTapClose()
    }
}
