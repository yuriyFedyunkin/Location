//
//  RegistrationViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

protocol RegistrationViewModel: AnyObject {
    var router: RegistrationRouter { get }
    func register(login: String?, password: String?)
}

final class RegistrationViewModelImpl: NSObject, RegistrationViewModel {
    
    let router: RegistrationRouter
    private let dataBase: UsersDB
    
    init(router: RegistrationRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
    }
    
    func register(login: String?, password: String?) {
        guard let login = login?.lowercased(),
              let password = password?.lowercased(),
              !(login.isEmpty && password.isEmpty)
        else {
            router.showEmptyAlert()
            return
        }
        
        let user = User(login: login, password: password)
        dataBase.write(user)
        
        router.pop()
    }
}
