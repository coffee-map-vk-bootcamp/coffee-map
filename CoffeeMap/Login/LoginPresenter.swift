//
//  LoginPresenter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//  
//

import Foundation

final class LoginPresenter {
    
    weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?
    
    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput
    
    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
    func signUp(email: String, pas: String, repeatPas: String) {
        switch VolidationManager.volidationSignUp(email: email, pas1: pas, pas2: repeatPas) {
        case .weakPassword:
            view?.addResult(result: "Пароль должен содержать не менее 4х символов")
            view?.animationFail()
        case .notEqualPass:
            view?.addResult(result: "Пароли не совпадают")
            view?.animationFail()
        case .notAllFields:
            view?.addResult(result: "Введите все поля")
            view?.animationFail()
        case .badEmail:
            view?.addResult(result: "Введите реальную почту")
            view?.animationFail()
        case .success:
            interactor.signUp(email: email, pas: pas)
        }
    }
    
    func login(email: String, pas: String) {
        interactor.login(email: email, pas: pas)
    }
    
    func cantSignUp() {
        view?.addResult(result: "этот email уже зарегистрирован")
        view?.animationFail()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func badData() {
        view?.addResult(result: "Пользователь не найден")
        view?.animationFail()
    }
    
    func goToMainScreen() {
        router.successLogin()
    }
}
