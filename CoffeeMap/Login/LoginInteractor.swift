//
//  LoginInteractor.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//  
//

import Foundation

final class LoginInteractor {
    weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func login(email: String, pas: String) {
        FBAuthService.login(email: email, password: pas) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                self?.output?.goToMainScreen()
            }
        }
    }
}
