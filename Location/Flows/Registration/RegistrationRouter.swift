//
//  RegistrationRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

protocol RegistrationRouter: BaseRouter {
    func showEmptyAlert()
}

final class RegistrationRouterImpl: BaseRouterImpl, RegistrationRouter {
    func showEmptyAlert() {
        let ac = UIAlertController(
            title: "Ошибка",
            message: "Все поля должны быть заполнены",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel)
        ac.addAction(action)
        present(ac)
    }
}
