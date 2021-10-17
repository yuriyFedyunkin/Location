//
//  RegistrationViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import UIKit

final class RegistrationViewController: LoginViewController {
    
    override func setupViews() {
        super.setupViews()
        loginButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.isHidden = true
    }
}
