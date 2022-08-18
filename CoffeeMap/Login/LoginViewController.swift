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
    
    internal var state: LoginState = .signIn {
        didSet {
            if oldValue != state {
                if oldValue == .signIn {
                    loginView.animateSignUp()
                } else {
                    loginView.animateSignIn()
                }
            }
        }
    }
    
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
    func showLogin() {
        print("login")
    }
}

extension LoginViewController: LoginViewOutputToVC {
    
    func trySignUp() {
        if state == .signIn {
            state = .signUp
        } else {
            guard let email = loginView.email, let pas = loginView.password, let repeatPas = loginView.repeatPassword else { return }
            output.signUp(email: email, pas: pas, repeatPas: repeatPas)
        }
    }
    
    func tryLogin() {
        if state == .signUp {
            state = .signIn
        } else {
            guard let email = loginView.email, let pas = loginView.password else { return }
            output.login(email: email, pas: pas)
        }
    }
    
    func goToSignUp() {
        print(#function)
    }
    
    func loginWithoutPas() {
        print(#function)
    }
}
