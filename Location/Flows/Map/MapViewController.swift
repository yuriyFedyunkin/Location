//
//  MapViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 08.10.2021.
//

import UIKit
import GoogleMaps
import CoreLocation
import RxSwift
import RxCocoa

final class MapViewController: UIViewController {

    // MARK: GoogleMaps
    private let mapView = GMSMapView()
    private var route: GMSPolyline?
    private var path: GMSMutablePath?
    private let marker = GMSMarker()
    
    // MARK: Helpers
    private var locationManager: LocationManager = LocationManagerImpl()
    private let avatarManager: AvatarManager = AvatarManagerImpl()
    
    private let avtarIcon = UIImageView()
    private let trackButton = UIBarButtonItem(
        title: "Start Track",
        style: .done, target: self,
        action: nil)
    private let exitButton = UIBarButtonItem(
        title: "Exit",
        style: .plain,
        target: self,
        action: nil)
    
    private var isTracking: Bool = false
    private var savedCoord: [CLLocationCoordinate2D] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = trackButton
        navigationItem.leftBarButtonItem = exitButton
        
        view.addSubview(mapView)
        mapView.frame = view.bounds

        avtarIcon.frame.size = CGSize(width: 48, height: 48)
        avtarIcon.contentMode = .scaleAspectFit
        avtarIcon.layer.cornerRadius = avtarIcon.frame.size.height / 2
        avtarIcon.layer.borderWidth = 1
        avtarIcon.layer.borderColor = UIColor.green.cgColor
        avtarIcon.clipsToBounds = true
        avtarIcon.image = avatarManager.readAvatarImage()
        
        marker.iconView = avtarIcon
        marker.map = mapView
    }
    
    private func setupBindings() {
        locationManager.authorizationStatus
            .subscribe(
                with: self,
                onNext: { $0.checkAuthorizationStatus(status: $1) })
            .disposed(by: disposeBag)

        locationManager.location
            .observe(on: MainScheduler.instance)
            .subscribe(
                with: self,
                onNext: {
                    $0.updateRoute(location: $1)
                    $0.marker.position = $1
                })
            .disposed(by: disposeBag)
        
        trackButton.rx.tap
            .bind { [weak self] _ in self?.handleTrackButtonTap() }
            .disposed(by: disposeBag)
        
        exitButton.rx.tap
            .bind { [weak self] _ in self?.exitMap() }
            .disposed(by: disposeBag)
    }
    
    private func checkAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAuthorization()
        case .restricted, .denied:
            print("Location access denien")
        case .authorizedAlways , .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }

    private func updateRoute(location: CLLocationCoordinate2D) {
        let position = GMSMutableCameraPosition(target: location, zoom: 16)
        mapView.animate(to: position)
        path?.add(location)
        route?.path = path
    }
    
    private func startNewTrack() {
        route?.map = mapView
        route = GMSPolyline()
        route?.strokeWidth = 3
        route?.strokeColor = .purple
        path = GMSMutablePath()
        route?.map = mapView
    }
    
    private func addPointToTrack(at coordinate: CLLocationCoordinate2D) {
        path?.add(coordinate)
        route?.path = path
    }
    
    private func handleTrackButtonTap() {
        if isTracking,
        let path = path {
            locationManager.stoptUpdateLocation()
            isTracking = false

            for i in 0...path.count() {
                savedCoord.append(path.coordinate(at: i))
                // TODO: Save coordinates to DB
            }
        } else if !isTracking {
            locationManager.startUpdateLocation()
            isTracking = true
            startNewTrack()
        }
        trackButton.title = isTracking ? "Stop track" : "Start track"
    }
    
    private func exitMap() {
        navigationController?.popViewController(animated: true)
    }
}
