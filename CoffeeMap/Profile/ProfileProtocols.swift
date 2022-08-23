//
//  ProfileProtocols.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func didLoad(user: User)
}

protocol ProfileViewOutput: AnyObject {
    var count: Int { get }

    func item(at index: Int) -> Order

    func loadUser()

    func prepare(data model: Order) -> ReceiptCellModel
    
    func logout()
}

protocol ProfileInteractorInput: AnyObject {
    func obtainUser()
}

protocol ProfileInteractorOutput: AnyObject {
    func didObtain(_ user: User)
    func didFail(with error: Error)
}

protocol ProfileRouterInput: AnyObject {
    func logout()
}

protocol ProfileHeaderOutput: AnyObject {
    func logout()
}
