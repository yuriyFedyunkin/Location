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
        show(viewController: MapViewController())
    }
}
