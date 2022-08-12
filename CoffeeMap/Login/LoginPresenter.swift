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
        FBAuthService.login(email: email, password: pas) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                self?.router.successLogin()
            }
        }
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
