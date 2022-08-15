//
//  LoginViewController.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//  
//

import UIKit

final class LoginViewController: UIViewController {
    private let output: LoginViewOutput
    
    private lazy var loginView: LoginView = {
        loginView = LoginView()
        loginView.delegate = self
        
        return loginView
    }()

    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.toAutoLayout()
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LoginViewController: LoginViewInput {
    
}

extension LoginViewController: LoginViewOutputToVC {
    func tryLogin() {
        guard let email = loginView.email, let pas = loginView.password else { return }
        output.login(email: email, pas: pas)
    }
    
    func goToSignUp() {
        print(#function)
    }
    
    func loginWithoutPas() {
        print(#function)
    }
}
