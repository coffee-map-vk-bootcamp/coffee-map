//
//  ProfileInteractor.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//  
//

import Foundation

final class ProfileInteractor {
	weak var output: ProfileInteractorOutput?
    private let networkManager: NetworkManagerDescription

    init(networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func obtainUser() {
        networkManager.fetchUserData { [weak self] result in
            switch result {
            case .success(let user):
                print("HERE")
                self?.output?.didObtain(user)
            case .failure(let error):
                self?.output?.didFail(with: error)
            }
        }
    }
}
