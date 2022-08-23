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
    
    private lazy var signUpButton: UIButton = {
        signUpButton = UIButton()
        signUpButton.backgroundColor = AppColors.primary
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        signUpButton.layer.cornerRadius = 16
        signUpButton.layer.masksToBounds = true
        signUpButton.toAutoLayout()
        addSubview(signUpButton)
        
        return signUpButton
    }()
    
    private lazy var withoutLogButton: UIButton = {
        withoutLogButton = UIButton()
        withoutLogButton.setTitle("Войти без пароля", for: .normal)
        withoutLogButton.setTitleColor(AppColors.primary, for: .normal)
        
        withoutLogButton.layer.cornerRadius = 16
        withoutLogButton.layer.masksToBounds = true
        withoutLogButton.toAutoLayout()
        addSubview(withoutLogButton)
        
        return withoutLogButton
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
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            logoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            
            resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            logInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 32),
            
            signUpButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            withoutLogButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            withoutLogButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 32),
            withoutLogButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor)
        ])
    }
    
    func addResult(result: String) {
        resultLabel.text = result
    }

    private func setup() {
        addSubview(resultLabel)
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
        passwordTextField.addSubview(activity)
        
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
        repeatPasswordTextField.addSubview(activity)
        
        addSubview(repeatPasswordTextField)
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
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
