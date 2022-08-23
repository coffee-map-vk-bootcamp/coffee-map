//
//  CoffeeShopDetailHeaderView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

class CoffeeShopDetailHeaderView: UICollectionReusableView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coffeeShop: CoffeeShop) {
        headerImageView.setImage(with: coffeeShop.image)
        headerTitleLabel.text = coffeeShop.name
    }
}

private extension CoffeeShopDetailHeaderView {
    func setup() {
        setupHeaderImageView()
        setupGradientLayer()
        setupHeaderTitleLabel()
        
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
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            headerTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
