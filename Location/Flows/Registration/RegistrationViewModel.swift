//
//  RegistrationViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RxSwift

protocol RegistrationViewModel: AnyObject {
    var router: RegistrationRouter { get }
    var userInput: AnyObserver<(String, String)> { get }
}

final class RegistrationViewModelImpl: NSObject, RegistrationViewModel {
    
    // MARK: RegistrationViewModel protocol
    let router: RegistrationRouter
    let userInput: AnyObserver<(String, String)>
    
    // MARK: Local properties
    private let dataBase: UsersDB
    private let disposeBag = DisposeBag()
    private var registerDidTap: Binder<User> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, user in
            vm.dataBase.write(user)
            vm.router.pop()
        })
    }
    
    init(router: RegistrationRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
        
        let userInputSubject = PublishSubject<(String, String)>()
        userInput = userInputSubject.asObserver()
        super.init()
        
        userInputSubject
            .map { User(login: $0.lowercased(), password: $1.lowercased()) }
            .bind(to: registerDidTap)
            .disposed(by: disposeBag)
    }
}
