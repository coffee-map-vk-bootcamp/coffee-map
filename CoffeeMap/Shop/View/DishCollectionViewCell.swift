//
//  DishCollectionViewCell.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import UIKit

final class DishCollectionViewCell: UICollectionViewCell {
    
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .dishItemName
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .dishItemName
        return label
    }()
    
    lazy var blurView = UIVisualEffectView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layoutNameLabel()
        layoutPriceLabel()
    }
    
    func setupContainer() {
        
        let image = UIImage(named: "coffee-test-1")
        let imageView = UIImageView()
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        blurView.effect = blurEffect
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 4
        blurView.layer.masksToBounds = true

        contentView.addSubview(blurView)
        contentView.addSubview(imageView)

        imageView.sizeToFit()

        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 95)
        ])

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: blurView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
        ])
    }
    
    func setupViews() {
        contentView.addSubview(dishNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func layoutNameLabel() {
        dishNameLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            dishNameLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            dishNameLabel.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 20)
        ])
    }
    
    func layoutPriceLabel() {
        priceLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 6)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishNameLabel.text = nil
        priceLabel.text = nil
    }
    
}
