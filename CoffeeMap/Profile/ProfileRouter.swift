//
//  ProfileRouter.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//  
//

import UIKit

final class ProfileRouter {
    weak var controller: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func logout() {
        FBAuthService.logout { result in
            switch result {
            case .success:
                let context = LoginContext()
                let login = LoginContainer.assemble(with: context).viewController
                let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
                controller?.dismiss(animated: true) {
                    window?.rootViewController = login
                    window?.makeKeyAndVisible()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
