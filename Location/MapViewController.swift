//
//  MapViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 08.10.2021.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {

    private let mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
    }
}

