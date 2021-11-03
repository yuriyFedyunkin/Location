//
//  MenuViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import UIKit

final class MenuViewController: UIViewController {
    
    var viewModel: MenuViewModel!

    private let showMapButton = BaseButton()
    private let appearance = Appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = appearance.title
        
        showMapButton.setTitle(appearance.mapButtonTitle, for: .normal)
        showMapButton.layer.cornerRadius = appearance.buttonSize.height / 2
        showMapButton.backgroundColor = .black
        view.addSubview(showMapButton)
        showMapButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(appearance.buttonSize)
        }
    }
}

extension MenuViewController {
    struct Appearance {
        let title = "Меню"
        let mapButtonTitle = "Карта"
        let buttonSize = CGSize(width: 150, height: 40)
    }
}

