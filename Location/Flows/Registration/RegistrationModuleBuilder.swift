//
//  RegistrationModuleBuilder.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

final class RegistrationModuleBuilder {
    
    static func configure(with vc: RegistrationViewController) {
        let router = RegistrationRouterImpl(viewController: vc)
        let vm = RegistrationViewModelImpl(router: router)
        vc.viewModel = vm
    }
}
