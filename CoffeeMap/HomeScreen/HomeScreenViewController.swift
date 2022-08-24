//
//  HomeScreenViewController.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//  
//

import UIKit
import MapKit
import CoreLocation
import UBottomSheet

final class HomeScreenViewController: UIViewController {
    var sheetCoordinator: UBottomSheetCoordinator?
    var dataSource: UBottomSheetCoordinatorDataSource?
    var sheetVC: DraggableItem?
    
    private var userLocation: CLLocation?
    
    private var lastSelectedAnnotation: MKAnnotation?
    
    private var locationManager: CLLocationManager?
    
    private var isShowingBottomSheet = false
    
    private var tappedCoffeeShop: CoffeeShop?
    private var lastAnnotations: [MKAnnotation] = []
    
    private let output: HomeScreenViewOutput
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .mutedStandard
        mapView.showsBuildings = true
        return mapView
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .primary
        return button
    }()
    
    init(output: HomeScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutMapView()
        layoutLocationButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func startShowingBottomSheet() {
        if !isShowingBottomSheet {
            showBottomSheet()
            isShowingBottomSheet = true
        } else {
            sheetCoordinator?.removeSheet()
            showBottomSheet()
        }
    }
}

private extension HomeScreenViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        setupLocationManager()
        output.didLoadView()
        setupViews()
        setupMap()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
    }
    
    func setupViews() {
        let views = [mapView, locationButton]
        view.addSubviews(views)
    }
    
    func setupMap() {
//        let initialLocation = userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 43.41243, longitude: 39.96577)
//        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
//        mapView.setRegion(region, animated: true)
        locateToUserLocation()
        mapView.delegate = self
    }
    
    func layoutMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func layoutLocationButton() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -76),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationButton.heightAnchor.constraint(equalToConstant: 48),
            locationButton.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        locationButton.addTarget(self, action: #selector(locateToUserLocation), for: .touchUpInside)
    }
    
    @objc func locateToUserLocation() {
        let coordinate = userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 43.41243, longitude: 39.96577)
        let latCorrection = mapView.region.span.latitudeDelta / 8
        print(mapView.region.span, latCorrection)
        let region = MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    
    func showBottomSheet() {
        guard let dataSource = dataSource,
              var sheetVC = sheetVC
        else { return }
        
        let sheetCoordinator = UBottomSheetCoordinator(parent: self)
        sheetCoordinator.dataSource = dataSource
        
        self.sheetCoordinator = sheetCoordinator
        sheetCoordinator.delegate = self
        
        sheetVC.sheetCoordinator = sheetCoordinator
        sheetCoordinator.addSheet(sheetVC, to: self, didContainerCreate: { container in
            let frame = self.view.frame
            let rect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            container.roundCorners(corners: [.topLeft, .topRight], radius: 10, rect: rect)
        })
    }
}

extension HomeScreenViewController: HomeScreenViewInput {
    func showLocations(_ shops: [CoffeeShop]) {
        
        mapView.removeAnnotations(lastAnnotations)
        
        var annotations = [MKPointAnnotation]()
        
        for shop in shops {
            let location = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            let point = CoffeeShopAnnotation()
            
            point.title = shop.name
            point.coordinate = location
            point.coffeeShop = shop
            annotations.append(point)
        }
        
        lastAnnotations = annotations
        mapView.addAnnotations(annotations)
    }
}

extension HomeScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CoffeeShopMarkerAnnotationView")
        
        if annotationView == nil {
            let markerView = CoffeeShopMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeShopMarkerAnnotationView")
            annotationView = markerView
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CoffeeShopAnnotation {
            let latCorrection = mapView.region.span.latitudeDelta / 4 + mapView.region.span.latitudeDelta / 8
            
            let region = MKCoordinateRegion(center: .init(latitude: annotation.coordinate.latitude - latCorrection,
                                                          longitude: annotation.coordinate.longitude),
                                            span: mapView.region.span)
            
            mapView.setRegion(region, animated: true)
            
            lastSelectedAnnotation = annotation
            
            if let coffeeShop = annotation.coffeeShop {
                output.openDetail(with: coffeeShop)
            }
        } else if let annotation = view.annotation as? MKClusterAnnotation {
            let latCorrection = mapView.region.span.latitudeDelta / 8
            let span = MKCoordinateSpan(latitudeDelta: latCorrection, longitudeDelta: latCorrection)
            
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
        }
    }
}

extension HomeScreenViewController: UBottomSheetCoordinatorDelegate {
    func bottomSheet(_ container: UIView?, finishTranslateWith extraAnimation: @escaping ((CGFloat) -> Void) -> Void) {
        extraAnimation { [weak self] num in
            if num < 0, let annotation = self?.lastSelectedAnnotation {
                self?.mapView.deselectAnnotation(annotation, animated: true)
                self?.isShowingBottomSheet = false
            }
        }
    }
}

extension HomeScreenViewController: CLLocationManagerDelegate {
    func activateLocationServices() {
        locationManager?.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        let status = manager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            activateLocationServices()
        } else if status == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.first else { return }
        
        userLocation = latest
        
    }
}
