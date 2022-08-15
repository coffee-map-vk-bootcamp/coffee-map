//
//  LoginProtocols.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 12.08.2022.
//  
//

import Foundation

protocol LoginModuleInput {
    var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: AnyObject {
}

protocol LoginViewInput: AnyObject {
}

protocol LoginViewOutput: AnyObject {
    func login(email: String, pas: String)
}

protocol LoginInteractorInput: AnyObject {
    func login(email: String, pas: String)
}

protocol LoginInteractorOutput: AnyObject {
    func goToMainScreen()
}

protocol LoginRouterInput: AnyObject {
    func successLogin()
}

protocol LoginViewOutputToVC: AnyObject {
    func tryLogin()
    func goToSignUp()
    func loginWithoutPas()
}
