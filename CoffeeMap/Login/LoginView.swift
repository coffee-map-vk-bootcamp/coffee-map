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
    private let repeatPasswordTextField = UITextField()
    
    private lazy var repeatPasswordTextFieldAncor: NSLayoutConstraint = {
        let repeatPasswordTextField = repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 0)
        
        return repeatPasswordTextField
    }()
    
    var email: String? {
        return emailTextField.text
    }
    
    var password: String? {
        return passwordTextField.text
    }
    
    var repeatPassword: String? {
        return repeatPasswordTextField.text
    }
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    private lazy var logoView: UIImageView = {
        logoView = UIImageView(image: UIImage(named: "logo"))
        logoView.layer.cornerRadius = 100
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.toAutoLayout()
        
        return logoView
    }()
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.textColor = .red
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.toAutoLayout()
        
        return resultLabel
    }()
    
    private lazy var logInButton: UIButton = {
        logInButton = UIButton()
        logInButton.backgroundColor = AppColors.primary
        logInButton.setTitle("Вход", for: .normal)
        logInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        logInButton.layer.cornerRadius = 16
        logInButton.layer.masksToBounds = true
        logInButton.toAutoLayout()
        
        return logInButton
    }()
    
    lazy var signUpButton: UIButton = {
        signUpButton = UIButton()
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.setTitleColor(AppColors.primary, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        signUpButton.layer.cornerRadius = 16
        signUpButton.layer.masksToBounds = true
        signUpButton.toAutoLayout()
        scrollView.addSubview(signUpButton)
        
        return signUpButton
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        repeatPasswordTextFieldAncor.isActive = true
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            //logoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            logoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            logoView.bottomAnchor.constraint(equalTo: resultLabel.topAnchor, constant: -12),
            
            resultLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            resultLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            resultLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            logInButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 32),
            
            signUpButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func addResult(result: String) {
        resultLabel.text = result
    }

    private func setup() {
        scrollView.addSubview(resultLabel)
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
        addRepeatPasswordTextField()
        
        scrollView.addSubview(stackView)
    }
    
    private func addEmailTextField() {
        emailTextField.toAutoLayout()
        emailTextField.backgroundColor = .systemGray6
        emailTextField.textColor = .black
        emailTextField.placeholder = "Почта"
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        
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
        passwordTextField.isSecureTextEntry = true

        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        passwordTextField.setLeftPaddingPoints(16)
        
        stackView.addArrangedSubview(passwordTextField)
    }
    
    private func addRepeatPasswordTextField() {
        repeatPasswordTextField.toAutoLayout()
        repeatPasswordTextField.backgroundColor = .systemGray6
        repeatPasswordTextField.textColor = .black
        repeatPasswordTextField.placeholder = "Повторите пароль"
        repeatPasswordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        repeatPasswordTextField.autocapitalizationType = .none
        repeatPasswordTextField.isSecureTextEntry = true
        
        repeatPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        repeatPasswordTextField.layer.borderWidth = 0.5
        repeatPasswordTextField.layer.cornerRadius = 10
        repeatPasswordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        repeatPasswordTextField.setLeftPaddingPoints(16)
        
        scrollView.addSubview(repeatPasswordTextField)
    }
        
    @objc
    func loginTapped() {
        delegate?.tryLogin()
    }
    
    @objc
    func signUp() {
        delegate?.trySignUp()
    }
    
    func animateSignUp() {
        repeatPasswordTextFieldAncor.isActive = false
        passwordTextField.text = ""
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0, options: []) { [self] in
            passwordTextField.layer.cornerRadius = 0
            passwordTextField.layer.maskedCorners = []
            self.repeatPasswordTextFieldAncor.constant = 50
            self.repeatPasswordTextFieldAncor.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    func animateSignIn() {
        repeatPasswordTextFieldAncor.isActive = false
        repeatPasswordTextField.text = ""
        passwordTextField.text = ""
        signUpButton.setTitle("Регистрация", for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0, options: []) { [weak self] in
            self?.passwordTextField.layer.cornerRadius = 10
            self?.passwordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            self?.repeatPasswordTextFieldAncor.constant = 0
            self?.repeatPasswordTextFieldAncor.isActive = true
            self?.layoutIfNeeded()
        }
    }
    
    func animationFail() {
        stackView.shake()
        repeatPasswordTextField.shake()
    }
    
    func animationLoading() {
        logoView.rotation()
    }
    
    func stopLoading() {
        logoView.layer.removeAllAnimations()
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
