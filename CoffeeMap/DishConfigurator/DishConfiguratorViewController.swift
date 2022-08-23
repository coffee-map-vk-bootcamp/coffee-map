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
        
        visualEffectView.alpha = 0
        alertView.alpha = 0
        
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
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
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapVisual))
        visualEffectView.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func didTapVisual() {
        animateOut()
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.4,
                       animations: {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { [weak self] _ in
            self?.output.didTapClose()
        }
    }
}

extension DishConfiguratorViewController: DishConfigurationAlertViewDelegate {
    func didTapClose() {
        animateOut()
    }
}
