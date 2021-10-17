//
//  LoginModuleBuidler.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

final class LoginModuleBuidler {
    
    static func configure(with vc: LoginViewController) {
        let router = LoginRouterImpl(viewController: vc)
        let vm = LoginViewModelImpl(router: router)
        vc.viewModel = vm
    }
}
