//
//  MapPresentableRouter.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 17.10.2021.
//

import Foundation
import UIKit

protocol MapPresentableRouter: BaseRouter {
    func showMap()
}

extension MapPresentableRouter {
    func showMap() {
        let vc = MapViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.modalTransitionStyle = .crossDissolve
        nc.modalPresentationStyle = .overFullScreen
        
        present(nc)
    }
}
