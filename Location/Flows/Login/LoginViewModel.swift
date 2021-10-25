//
//  LoginViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

protocol LoginViewModel: AnyObject {
    var router: LoginRouter { get }
    func loginButtonTapped(login: String?, password: String?)
    func showRegistration()
}

final class LoginViewModelImpl: NSObject, LoginViewModel {
    let router: LoginRouter
    private let dataBase: UsersDB
    
    init(router: LoginRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
    }
    
    func loginButtonTapped(login: String?, password: String?) {
        guard let login = login?.lowercased(),
              let password = password?.lowercased(),
              !(login.isEmpty && password.isEmpty)
        else {
            router.showAlert(.emptyField)
            return
        }
        
        if let user = dataBase.read(login: login),
           password == user.password {
            router.showMap()
        } else {
            router.showAlert(.loginError)
        }
    }
    
    func showRegistration() {
        router.showRegistration()
    }
}
