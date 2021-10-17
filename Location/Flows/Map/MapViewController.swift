//
//  MapViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 08.10.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

final class MapViewController: UIViewController {

    private let mapView = GMSMapView()
    private var locationManager: CLLocationManager?
    private var isTracking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureLocationManager()
    }

    private func setupViews() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        let navBarButton = UIBarButtonItem(
            title: "Track",
            style: .done,
            target: self,
            action: #selector(trackLocation))
        
        let exitButton = UIBarButtonItem(
            title: "Exit",
            style: .plain,
            target: self,
            action: #selector(exitMap))
    
        navigationItem.rightBarButtonItem = navBarButton
        navigationItem.leftBarButtonItem = exitButton
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
    }
    
    private func addMarker(at coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
    }
    
    @objc private func trackLocation() {
        if isTracking {
            locationManager?.stopUpdatingLocation()
            isTracking = false
        } else {
            locationManager?.startUpdatingLocation()
            isTracking = true
        }
    }
    
    @objc private func exitMap() {
        navigationController?.dismiss(animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let cameraPosition = GMSCameraPosition(target: location.coordinate, zoom: 15)
        mapView.camera = cameraPosition
        addMarker(at: location.coordinate)
    }
}

