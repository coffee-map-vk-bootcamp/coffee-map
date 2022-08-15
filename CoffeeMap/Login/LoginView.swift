//
//  LoginView.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//
import UIKit

class LoginView: UIView {
    weak var delegate: LoginViewOutputToVC?
    
    private let stackView = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    var email: String? {
        get {
            return emailTextField.text
        }
    }
    
    var password: String? {
        get {
            return passwordTextField.text
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        activity = UIActivityIndicatorView()
        activity.toAutoLayout()
        
        return activity
    }()
    
    private lazy var logoView: UIImageView = {
        logoView = UIImageView(image: UIImage(named: "logo"))
        logoView.layer.cornerRadius = 100
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.toAutoLayout()
        
        return logoView
    }()
    
    private lazy var logInButton: UIButton = {
        logInButton = UIButton()
        logInButton.backgroundColor = .red
        logInButton.setTitle("Вход", for: .normal)
        logInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        logInButton.layer.cornerRadius = 16
        logInButton.layer.masksToBounds = true
        logInButton.toAutoLayout()
        
        return logInButton
    }()
    
    private lazy var signUpButton: UIButton = {
        signUpButton = UIButton()
        signUpButton.backgroundColor = .red
        signUpButton.setTitle("Регистрация", for: .normal)
        
        signUpButton.layer.cornerRadius = 16
        signUpButton.layer.masksToBounds = true
        signUpButton.toAutoLayout()
        addSubview(signUpButton)
        
        return signUpButton
    }()
    
    private lazy var withoutLogButton: UIButton = {
        withoutLogButton = UIButton()
        withoutLogButton.setTitle("Войти без пароля", for: .normal)
        withoutLogButton.setTitleColor(UIColor.brown, for: .normal)
        
        withoutLogButton.layer.cornerRadius = 16
        withoutLogButton.layer.masksToBounds = true
        withoutLogButton.toAutoLayout()
        addSubview(withoutLogButton)
        
        return withoutLogButton
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            logoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 80),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            
            signUpButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            withoutLogButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            withoutLogButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 32),
            withoutLogButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            
            activity.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            activity.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -8),
            activity.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            activity.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func setupStack() {
        scrollView.addSubviews([logoView, logInButton])
        self.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        scrollView.isScrollEnabled = false
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addEmailTextField()
        addPasswordTextField()
        
        scrollView.addSubview(stackView)
    }
    
    private func addEmailTextField() {
        emailTextField.toAutoLayout()
        emailTextField.backgroundColor = .systemGray6
        emailTextField.textColor = .black
        emailTextField.placeholder = "Почта"
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.autocapitalizationType = .none
        
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailTextField.setLeftPaddingPoints(16)
        
        stackView.addArrangedSubview(emailTextField)
    }
    
    private func addPasswordTextField() {
        passwordTextField.toAutoLayout()
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.placeholder = "Пароль"
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = false
        
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        passwordTextField.setLeftPaddingPoints(16)
        passwordTextField.addSubview(activity)
        
        stackView.addArrangedSubview(passwordTextField)
    }
        
    @objc
    func loginTapped() {
        delegate?.tryLogin()
    }
}
