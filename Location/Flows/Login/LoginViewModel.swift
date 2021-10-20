//
//  LoginViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RxSwift

protocol LoginViewModel: AnyObject {
    var router: LoginRouter { get }
    var loginDidTap: AnyObserver<Void> { get }
    var loginInput: AnyObserver<String> { get }
    var passwordInput: AnyObserver<String> { get }
    var didTapRegistration: Binder<Void> { get }
}

final class LoginViewModelImpl: NSObject, LoginViewModel {
    
    // MARK: LoginViewModel protocol
    let router: LoginRouter
    let loginDidTap: AnyObserver<Void>
    let loginInput: AnyObserver<String>
    let passwordInput: AnyObserver<String>
    var didTapRegistration: Binder<Void> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, _ in
            vm.router.showRegistration() })
    }
    
    // MARK: Local properties
    private let dataBase: UsersDB
    private let disposeBag = DisposeBag()
    
    init(router: LoginRouter, dataBase: UsersDB = UsersDBImpl.shared) {
        self.router = router
        self.dataBase = dataBase
        
        let loginDidTapSubject = PublishSubject<Void>()
        loginDidTap = loginDidTapSubject.asObserver()
        
        let loginInputSubject = PublishSubject<String>()
        loginInput = loginInputSubject.asObserver()
        
        let passwordInputSubject = PublishSubject<String>()
        passwordInput = passwordInputSubject.asObserver()
        super.init()
        
        let inputObservable = Observable.combineLatest(loginInputSubject, passwordInputSubject)
        
        loginDidTapSubject
            .observe(on: MainScheduler.instance)
            .withLatestFrom(inputObservable)
            .bind(with: self) { vm, input in
                vm.loginButtonTapped(login: input.0, password: input.1)
            }
            .disposed(by: disposeBag)
    }
    
    private func loginButtonTapped(login: String, password: String) {
        if let user = dataBase.read(login: login.lowercased()),
           password.lowercased() == user.password {
            router.showMap()
        } else {
            router.showAlert(.loginError)
        }
    }
}
