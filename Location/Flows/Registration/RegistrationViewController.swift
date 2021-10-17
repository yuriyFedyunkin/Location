//
//  RegistrationViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel!
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    
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
        loginTextField.placeholder = appearance.loginPlaceholder
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(appearance.fieldHeight)
            make.left.right.equalToSuperview().inset(appearance.inset)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-appearance.inset)
        }
        
        registerButton.setAttributedTitle(appearance.register, for: .normal)
        registerButton.layer.cornerRadius = appearance.buttonSize.height / 2
        registerButton.backgroundColor = .black
        registerButton.addTarget(self, action: #selector(registerTap), for: .touchUpInside)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.size.equalTo(appearance.buttonSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(appearance.inset)
        }
    }
    
    @objc private func registerTap() {
        viewModel.register(
            login: loginTextField.text,
            password: passwordTextField.text)
    }
}

extension RegistrationViewController {
    struct Appearance {
        let inset: CGFloat = 16
        let fieldHeight: CGFloat = 30
        let cornerRadius: CGFloat = 6
        let loginPlaceholder = "Login"
        let passwordPlaceholder = "Password"
        let title = "Регистрация"
        let buttonSize = CGSize(width: 150, height: 40)
        let register = NSAttributedString(
            string: "Зарегистрироваться",
            attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.white])
    }
}
