//
//  RegistrationPresentableRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

protocol RegistrationPresentableRouter: BaseRouter {
    func showRegistration()
}

extension RegistrationPresentableRouter {
    func showRegistration() {
        let vc = RegistrationViewController()
        RegistrationModuleBuilder.configure(with: vc)
        show(viewController: vc)
    }
}
