//
//  AvatarView.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import UIKit

final class AvatarView: UIView {
    
    private let defaultImageView = UIImageView()
    private let avatarImageView = UIImageView()
    
    private let appearance = Appearance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        
        defaultImageView.image = appearance.defaultImage
        defaultImageView.tintColor = .darkGray
        defaultImageView.contentMode = .scaleAspectFit
        addSubview(defaultImageView)
        defaultImageView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    func setAvatar(with image: UIImage?) {
        DispatchQueue.main.async {
            self.avatarImageView.image = image
            self.setNeedsDisplay()
        }
    }
}

extension AvatarView {
    struct Appearance {
        let defaultImage = UIImage(systemName: "camera")
    }
}
