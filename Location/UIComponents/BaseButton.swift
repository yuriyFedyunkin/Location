//
//  BaseButton.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 20.10.2021.
//

import UIKit

final class BaseButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.4) {
                self.backgroundColor = self.isEnabled ? .black : .placeholderText
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, delay: .zero, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: .curveEaseInOut) {
                self.transform = self.isHighlighted ?
                CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.black, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
