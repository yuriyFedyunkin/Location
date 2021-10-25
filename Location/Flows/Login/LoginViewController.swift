//
//  LoginViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    private let loginButton = UIButton()
    
    private let appearance = Appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        loginButton.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.size.equalTo(appearance.buttonSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(appearance.inset)
        }
        
        registerButton.setTitle(appearance.register, for: .normal)
        registerButton.addTarget(self, action: #selector(registerTap), for: .touchUpInside)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(appearance.inset)
            make.height.equalTo(appearance.fieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(appearance.inset)
        }
    }
    
    @objc private func loginTap() {
        viewModel.loginButtonTapped(
            login: loginTextField.text,
            password: passwordTextField.text)
    }
    
    @objc private func registerTap() {
        viewModel.showRegistration()
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
