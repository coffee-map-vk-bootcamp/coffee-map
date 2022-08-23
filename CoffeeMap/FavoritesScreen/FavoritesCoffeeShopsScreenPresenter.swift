//
//  FavoritesCoffeeShopsScreenPresenter.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//  
//

import Foundation
import CoreLocation
import MapKit

final class FavoritesCoffeeShopsScreenPresenter: NSObject {
    private var userLocation: CLLocationCoordinate2D?
    private var locationManager: CLLocationManager?
    
    weak var view: FavoritesCoffeeShopsScreenViewInput?
    weak var moduleOutput: FavoritesCoffeeShopsScreenModuleOutput?
    
    private let router: FavoritesCoffeeShopsScreenRouterInput
    private let interactor: FavoritesCoffeeShopsScreenInteractorInput
    
    private(set) var favoriteShops = [CoffeeShop]()
    
    func deleteFavoriteShop(_ index: Int) {
        favoriteShops.remove(at: index)
    }
    
    init(router: FavoritesCoffeeShopsScreenRouterInput, interactor: FavoritesCoffeeShopsScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
    }
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenModuleInput {
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenViewOutput {
    func getCoffeeShops() -> [CoffeeShop] {
        return favoriteShops
    }
    
    func remove(at index: Int) {
        favoriteShops.remove(at: index)
    }
    
//    func locationSetter() -> CLLocationCoordinate2D {
//        guard let location = userLocation else { return }
//        return location
//    }
    
    func getFavoritesCoffeeShops() {
        interactor.fetchCoffeeShops()
    }
}

extension FavoritesCoffeeShopsScreenPresenter: FavoritesCoffeeShopsScreenInteractorOutput {
    func getShops(_ shops: [CoffeeShop]) {
        favoriteShops = shops
        view?.setCoffeeShops(favoriteShops)
    }
}

extension FavoritesCoffeeShopsScreenPresenter: CLLocationManagerDelegate {
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
        userLocation = latest.coordinate
    }
}
