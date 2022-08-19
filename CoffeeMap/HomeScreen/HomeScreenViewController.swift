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

final class HomeScreenViewController: UIViewController {
    private let output: HomeScreenViewOutput
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .mutedStandard
        mapView.showsBuildings = true
        return mapView
    }()
    
    private var tappedCoffeeShop: CoffeeShop?
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutMapView()
    }
}

private extension HomeScreenViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        setupViews()
        setupMap()
        output.didLoadView()
    }
    
    func setupViews() {
        let views = [mapView]
        view.addSubviews(views)
    }
    
    func setupMap() {
        let initialLocation = CLLocationCoordinate2D(latitude: 43.41243, longitude: 39.96577)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        mapView.register(CoffeeShopMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(CoffeeShopClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        mapView.setRegion(region, animated: true)
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
}

extension HomeScreenViewController: HomeScreenViewInput {
    func showLocations(_ shops: [CoffeeShop]) {
        
        var annotations = [MKPointAnnotation]()
        
        for shop in shops {
            let location = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            let point = CoffeeShopAnnotation()
            
            point.title = shop.name
            point.coordinate = location
            point.coffeeShop = shop
            annotations.append(point)
        }
        
        mapView.addAnnotations(annotations)
    }
}

extension HomeScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let coffeeShopAnnotation = annotation as? CoffeeShopAnnotation else { return nil }
        
        return CoffeeShopMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeShopMarkerAnnotationView")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CoffeeShopAnnotation else { return }
        
        let latCorrection = mapView.region.span.latitudeDelta / 4 + mapView.region.span.latitudeDelta / 8
        
        let region = MKCoordinateRegion(center: .init(latitude: annotation.coordinate.latitude - latCorrection,
                                                      longitude: annotation.coordinate.longitude),
                                        span: mapView.region.span)
        
        mapView.setRegion(region, animated: true)
        
        if let coffeeShop = annotation.coffeeShop {
            output.openDetail(with: coffeeShop)
        }
    }
}
