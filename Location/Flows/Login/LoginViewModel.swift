//
//  LoginViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RxSwift

protocol LoginViewModel: AnyObject {
    var router: LoginRouter { get }
    var userInput: AnyObserver<(String, String)> { get }
    var didTapRegistration: Binder<Void> { get }
}

final class LoginViewModelImpl: NSObject, LoginViewModel {
    
    // MARK: LoginViewModel protocol
    let router: LoginRouter
    var userInput: AnyObserver<(String, String)>
    var didTapRegistration: Binder<Void> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, _ in
            vm.router.showRegistration() })
    }
    
    // MARK: Local properties
    private let dataBase: UsersDB
    private let disposeBag = DisposeBag()
    private var loginDidTap: Binder<User> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, input in
            if let user = vm.dataBase.read(login: input.login),
               input.password == user.password {
                vm.router.showMenu()
            } else {
                vm.router.showAlert(.loginError)
            }
        })
    }
    
    init(router: LoginRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
        
        let userInputSubject = PublishSubject<(String, String)>()
        userInput = userInputSubject.asObserver()
        super.init()
        
        userInputSubject
            .map { User(login: $0.lowercased(), password: $1.lowercased()) }
            .bind(to: loginDidTap)
            .disposed(by: disposeBag)
    }
}
