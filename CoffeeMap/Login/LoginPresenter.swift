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
    func login(email: String, pas: String) {
        interactor.login(email: email, pas: pas)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func goToMainScreen() {
        router.successLogin()
    }
}
