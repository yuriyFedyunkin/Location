//
//  LoginRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

protocol LoginRouter: RegistrationPresentableRouter, MapPresentableRouter {
    func showAlert(_ alert: LoginRouterImpl.LoginAlert)
}

final class LoginRouterImpl: BaseRouterImpl, LoginRouter {
    
    enum LoginAlert {
        case loginError, emptyField
    }
    
    func showAlert(_ alert: LoginAlert) {
        let title: String = "Ошибка"
        let message: String
        
        switch alert {
        case .loginError:
            message = "Неверный логин или пароль"
        case .emptyField:
            message = "Все поля должны быть заполнены"
        }
        
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel)
        ac.addAction(action)
        present(ac)
    }
}
