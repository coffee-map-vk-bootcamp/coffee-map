//
//  CoffeeShopDetailHeaderView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

protocol CoffeeShopDetailHeaderViewDelegate: AnyObject {
    func checkIsFavorite()
    func changeChangeFavorite(_ isFavorite: Bool)
}

class CoffeeShopDetailHeaderView: UICollectionReusableView {
    weak var delegate: CoffeeShopDetailHeaderViewDelegate?
    
    private lazy var headerImageView: SkeletonImageView = {
        let headerView = SkeletonImageView()
        headerView.contentMode = .scaleAspectFill
        return headerView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.75).cgColor]
        return gradient
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var flagButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private var isFavorite: Bool = false
    private var coffeeShop: CoffeeShop?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coffeeShop: CoffeeShop, isFavorite: Bool) {
        self.coffeeShop = coffeeShop
        self.isFavorite = isFavorite
        setFavoriteButton(isFavorite)
        headerImageView.setImage(with: coffeeShop.image)
        headerTitleLabel.text = coffeeShop.name
    }
}

private extension CoffeeShopDetailHeaderView {
    func setFavoriteButton(_ isFavorite: Bool) {
        let imageName = isFavorite ? AppImageNames.favorite : AppImageNames.notFavorite
        let image = UIImage(named: imageName)
        flagButton.setBackgroundImage(image, for: .normal)
    }
    
    func setup() {
        setupHeaderImageView()
        setupGradientLayer()
        setupHeaderTitleLabel()
        setupFlagButton()
        
        clipsToBounds = true
    }
    
    func setupHeaderImageView() {
        addSubview(headerImageView)
        headerImageView.frame = bounds
    }
    
    func setupGradientLayer() {
        headerImageView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = headerImageView.bounds
    }
    
    func setupHeaderTitleLabel() {
        addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            headerTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupFlagButton() {
        addSubview(flagButton)
        flagButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            flagButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            flagButton.centerYAnchor.constraint(equalTo: headerTitleLabel.centerYAnchor, constant: 3),
            flagButton.heightAnchor.constraint(equalToConstant: 38),
            flagButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
    }
    
    @objc func addToFavorites() {
        isFavorite.toggle()
        delegate?.changeChangeFavorite(isFavorite)
        setFavoriteButton(isFavorite)
    }
}
