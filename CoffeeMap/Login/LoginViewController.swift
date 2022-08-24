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
        layout()
        loginView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKB))
        loginView.addGestureRecognizer(gesture)
        registerForKeyboardNotification()
    }
    
    deinit {
        removeForKeyboardNotification()
    }
    
    func layout() {
        loginView.toAutoLayout()
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let scrolSize = loginView.signUpButton.frame.maxY + keyboardSize.height - loginView.bounds.maxY + 18 + loginView.safeAreaInsets.top
        loginView.scrollView.contentSize = CGSize(width: loginView.bounds.width, height: loginView.bounds.height + scrolSize)
        loginView.scrollView.contentOffset = CGPoint(x: 0, y: 90)
        loginView.scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        loginView.scrollView.contentSize = CGSize(width: loginView.bounds.width, height: loginView.bounds.height - keyboardSize.height)
        loginView.scrollView.isScrollEnabled = false
    }
    
    @objc
    private func closeKB() {
        loginView.endEditing(true)
    }
}

extension LoginViewController: LoginViewInput {
    func addResult(result: String) {
        loginView.addResult(result: result)
    }
}

extension LoginViewController: LoginViewOutputToVC {
    
    func trySignUp() {
        loginView.animationLoading()
        if state == .signIn {
            state = .signUp
        } else {
            guard let email = loginView.email, let pas = loginView.password, let repeatPas = loginView.repeatPassword else { return }
            output.signUp(email: email, pas: pas, repeatPas: repeatPas)
        }
    }
    
    func tryLogin() {
        loginView.animationLoading()
        if state == .signUp {
            state = .signIn
        } else {
            guard let email = loginView.email, let pas = loginView.password else { return }
            output.login(email: email, pas: pas)
        }
    }
    
    func animationFail() {
        loginView.stopLoading()
        loginView.animationFail()
    }
}
