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
        FBAuthService.logout {
            let context = LoginContext()
            let vc = LoginContainer.assemble(with: context).viewController
            let window = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).window
            controller?.dismiss(animated: true) {
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }
        }
    }
}
