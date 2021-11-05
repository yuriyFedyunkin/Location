//
//  ShadowView.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 04.11.2021.
//

import UIKit

final class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setShadow()
    }
    
    func setShadow(
        color: UIColor = .black,
        opacity: Float = 0.7,
        offset: CGSize = .zero,
        radius: CGFloat = 10
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
