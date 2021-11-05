//
//  MenuModuleBuilder.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import Foundation

final class MenuModuleBuilder {
    
    static func configure(with vc: MenuViewController) {
        let router = MenuRouterImpl(viewController: vc)
        let vm = MenuViewModelImpl(router: router)
        vc.viewModel = vm
    }
}
