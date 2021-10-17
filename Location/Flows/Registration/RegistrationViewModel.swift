//
//  RegistrationViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation

protocol RegistrationViewModel: AnyObject {
    var router: RegistrationRouter { get }
}

final class RegistrationViewModelImpl: NSObject, RegistrationViewModel {
    let router: RegistrationRouter
    private let dataBase: UsersDB
    
    init(router: RegistrationRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
    }
}
