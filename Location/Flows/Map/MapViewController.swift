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
    private var route: GMSPolyline?
    private var path: GMSMutablePath?
    private var locationManager: CLLocationManager?
    private var isTracking: Bool = false
    
    private var savedCoord: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureLocationManager()
    }

    private func setupViews() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        let startTrackButton = UIBarButtonItem(
            title: "Start Track",
            style: .done,
            target: self,
            action: #selector(startTracking))
        
        let stopTrackButton = UIBarButtonItem(
            title: "Stop Track",
            style: .plain,
            target: self,
            action: #selector(stopTracking))
    
        navigationItem.rightBarButtonItem = startTrackButton
        navigationItem.leftBarButtonItem = stopTrackButton
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.showsBackgroundLocationIndicator = true
        locationManager?.requestAlwaysAuthorization()
    }
    
    private func addMarker(at coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
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
    
    @objc private func startTracking() {
        guard !isTracking else { return }
        locationManager?.startUpdatingLocation()
        isTracking = true
        startNewTrack()
    }
    
    @objc private func stopTracking() {
        guard isTracking, let path = path
        else { return }
        locationManager?.stopUpdatingLocation()
        isTracking = false
        
        for i in 0...path.count() {
            savedCoord.append(path.coordinate(at: i))
            // TODO: Save coordinates to DB
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
        addPointToTrack(at: location.coordinate)
    }
}

// TODO: Delete
/*
 На основе задания предыдущего урока.

 1. Настроить слежение за перемещением в фоне.

 2. Добавить кнопки «Начать новый трек» и «Закончить трек».

 3. При нажатии на «Начать новый трек»:
 a. Запускается слежение.
 b. Создаётся новая линия на карте или заменяется предыдущая.
 c. При получении новой точки она добавляется в маршрут.
 
 4. Добавить в приложение базу данных Realm.

 5. При нажатии на «Закончить трек»:

 a. Завершается слежение.
 b. Все точки маршрута сохраняются в базу данных.
 c. Прежде чем сохранить точки из базы, необходимо удалить предыдущие точки.
 6. Добавить кнопку «Отобразить предыдущий маршрут».

 7. При нажатии на «Отобразить предыдущий маршрут».

 a. Если в данный момент происходит слежение, то появляется уведомление о том, что сначала необходимо остановить слежение. С кнопкой «ОК», при нажатии на которую останавливается слежение, как если бы пользователь нажал на «Закончить трек».
 b. Загружаются точки из базы.
 c. На основе загруженных точек строится маршрут.
 d. Фокус на карте устанавливается таким образом, чтобы был виден весь маршрут.
 P.S. В документации к картам можно найти методы и свойства, которые помогут вам:

 1. Остановить слежение.

 2. Получить все точки из объекта GMSMutablePath.

 3. Установить фокус карты точно так, чтобы она отображала маршрут, описанный объектом GMSMutablePath.
 */
