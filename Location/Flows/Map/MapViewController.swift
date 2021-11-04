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

    private let mapView = GMSMapView()
    private var route: GMSPolyline?
    private var path: GMSMutablePath?
    private var locationManager: LocationManager = LocationManagerImpl()
    private let avatarManager: AvatarManager = AvatarManagerImpl()
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
        view.addSubview(mapView)
        mapView.frame = view.bounds
        navigationItem.rightBarButtonItem = trackButton
        navigationItem.leftBarButtonItem = exitButton
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
                onNext: { $0.updateRoute(location: $1) })
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
