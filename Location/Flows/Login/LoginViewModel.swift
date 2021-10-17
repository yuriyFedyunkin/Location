//
//  LoginViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

protocol LoginViewModel {
    
}

final class LoginViewModelImpl: LoginViewModel {
    
    private let dataBase: UsersDB
    
    init(dataBase: UsersDB = UsersDBImpl.shared) {
        self.dataBase = dataBase
    }
}
