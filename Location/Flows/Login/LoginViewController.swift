//
//  LoginViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import RxCocoa
import RxSwift
import SnapKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    private let loginButton = UIButton()
    
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }

    private func setupViews() {
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = appearance.title
        
        passwordTextField.backgroundColor = .white
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.layer.cornerRadius = appearance.cornerRadius
        passwordTextField.placeholder = appearance.passwordPlaceholder
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.centerY)
            make.left.right.equalToSuperview().inset(appearance.inset)
            make.height.equalTo(appearance.fieldHeight)
        }
        
        loginTextField.backgroundColor = .white
        loginTextField.layer.cornerRadius = appearance.cornerRadius
        loginTextField.textAlignment = .center
        loginTextField.autocorrectionType = .no
        loginTextField.placeholder = appearance.loginPlaceholder
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
            make.left.right.equalToSuperview().inset(appearance.inset)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-appearance.inset)
        }
        
        loginButton.setTitle(appearance.enter, for: .normal)
        loginButton.layer.cornerRadius = appearance.buttonSize.height / 2
        loginButton.backgroundColor = .black
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.size.equalTo(appearance.buttonSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(appearance.inset)
        }
        
        registerButton.setTitle(appearance.register, for: .normal)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(appearance.inset)
            make.height.equalTo(appearance.fieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(appearance.inset)
        }
    }

    private func setupBindings() {
        loginTextField.rx.text
            .orEmpty
            .bind(to: viewModel.loginInput)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordInput)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginDidTap)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .bind(to: viewModel.didTapRegistration)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            loginTextField.rx.text.orEmpty,
            passwordTextField.rx.text.orEmpty)
            .map { !$0.isEmpty && !$1.isEmpty }
            .distinctUntilChanged()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    struct Appearance {
        let inset: CGFloat = 16
        let fieldHeight: CGFloat = 30
        let cornerRadius: CGFloat = 6
        let loginPlaceholder = "Login"
        let passwordPlaceholder = "Password"
        let title = "Location App"
        let buttonSize = CGSize(width: 150, height: 40)
        let enter = "Войти"
        let register = "Зарегистрироваться"
    }
}
