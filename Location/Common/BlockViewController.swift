//
//  BlockViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 18.10.2021.
//

import UIKit
import SnapKit

final class BlockViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        
        titleLabel.text = "Location App"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
        }
    }
}
