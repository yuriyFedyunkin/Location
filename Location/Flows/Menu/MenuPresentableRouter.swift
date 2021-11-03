//
//  MenuPresentableRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import UIKit

protocol MenuPresentableRouter: BaseRouter {
    func showMenu()
}

extension MenuPresentableRouter {
    func showMenu() {
        let vc = MenuViewController()
        MenuModuleBuilder.configure(with: vc)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overFullScreen
        
        present(nc)
    }
}
