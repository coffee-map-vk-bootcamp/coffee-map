//
//  FavouritesCell.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol FavouriteCellDelegate: AnyObject {
    func remove(at index: Int)
}

final class FavouritesCell: UICollectionViewCell {
    private var userLocation: CLLocationCoordinate2D?
    private var locationManager: CLLocationManager?
    
    weak var delegate: FavouriteCellDelegate?
    var locationKeeper: CLLocation?
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Название кофейни"
        label.textColor = .white
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Адрес кофейни"
        label.textColor = .white
        return label
    }()
    
    private lazy var flagButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: AppImageNames.favorite)?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(deleteFavourite), for: .touchUpInside)
        return btn
    }()
    
    private lazy var markImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: AppImageNames.mark)?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "1 км."
        label.textColor = .white
        return label
    }()
    
    private lazy var distanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var backgroundImageView: SkeletonImageView = {
        let background = SkeletonImageView()
        background.clipsToBounds = true
        background.layer.addSublayer(gradientLayer)
        background.layer.cornerRadius = 14
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        return layer
    }()
    
    private var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLocationManager()
        setupViews()
        setupCell()
        setupDistanceViews()
        layout()
        layoutDistanceView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = contentView.bounds
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
    }
    
    func configure(with shop: CoffeeShop, index: Int) {
        placeLabel.text = shop.name
        addressLabel.text = shop.address
        backgroundImageView.setImage(with: shop.image)
        locationKeeper = CLLocation(latitude: shop.latitude, longitude: shop.longitude)
        self.index = index
    }
    
    private func setupViews() {
        let views = [distanceView, flagButton, addressLabel, placeLabel]
        contentView.addSubviews(views)
    }
    
    private func setupDistanceViews() {
        distanceView.addSubview(markImage)
        distanceView.addSubview(distanceLabel)
    }
    
    @objc private func deleteFavourite(sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        delegate?.remove(at: index)
    }
    
    private func setupCell() {
        contentView.addSubview(backgroundImageView)
        contentView.sendSubviewToBack(backgroundImageView)
    }
    
    private func layoutDistanceView() {
        NSLayoutConstraint.activate([
            markImage.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor),
            markImage.leadingAnchor.constraint(equalTo: distanceView.leadingAnchor),
            
            distanceLabel.leadingAnchor.constraint(equalTo: markImage.trailingAnchor, constant: -4),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor)
        ])
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            distanceView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            distanceView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            distanceView.widthAnchor.constraint(greaterThanOrEqualTo: distanceLabel.widthAnchor, constant: 26),
            distanceView.heightAnchor.constraint(equalToConstant: 20),
            
            flagButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            flagButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -14),
            flagButton.heightAnchor.constraint(equalToConstant: 28),
            flagButton.widthAnchor.constraint(equalToConstant: 24),
            
            placeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            placeLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension FavouritesCell: CLLocationManagerDelegate {
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
        let coordinate1 = CLLocation(latitude: (userLocation?.latitude) ?? 13.6028, longitude: (userLocation?.longitude) ?? 19.7342)
        let distance = (locationKeeper?.distance(from: coordinate1) ?? 0) / 1000
        if distance <= 1 {
            distanceLabel.text = "\(Int(distance * 1000)) м."
        } else if distance <= 100 {
            distanceLabel.text = "\(Int(distance)) км."
        } else {
            distanceLabel.text = ">100 км."
        }
    }
}
