//
//  LoginViewController.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 10.08.2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController{
    
    private lazy var loginView: UIView = {
        loginView = LoginView()
        loginView.toAutoLayout()
        view.addSubview(loginView)
        
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
}
