//
//  LocationManager.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 20.10.2021.
//

import CoreLocation
import RxSwift
import RxRelay

protocol LocationManager: AnyObject {
    var authorizationStatus: Observable<CLAuthorizationStatus> { get }
    var location: Observable<CLLocationCoordinate2D> { get }
    
    func requestAuthorization()
    func startUpdateLocation()
    func stoptUpdateLocation()
}

final class LocationManagerImpl: NSObject, LocationManager {
    
    private(set) lazy var authorizationStatus = _authorizationStatus.asObservable()
    private let _authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    private(set) lazy var location = _location.asObservable()
    private let _location = PublishRelay<CLLocationCoordinate2D>()
    
    private let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.requestAlwaysAuthorization()
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdateLocation() {
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stoptUpdateLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManagerImpl: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        _authorizationStatus.accept(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { _location.accept($0.coordinate) }
    }
}
