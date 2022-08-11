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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .dishItemName
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .dishItemName
        return label
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 4
        blurView.layer.masksToBounds = true
        return blurView
    }()
    
    lazy var dishImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setupDishImageView()
        setupNameLabel()
        setupPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDishImageView() {
        contentView.addSubview(dishImageView)
        
        let image = UIImage(named: AppImageNames.mockDishImage1)
        
        dishImageView.image = image
        dishImageView.contentMode = .scaleAspectFit
        
        dishImageView.translatesAutoresizingMaskIntoConstraints = false

        dishImageView.sizeToFit()

        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            dishImageView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            dishImageView.topAnchor.constraint(equalTo: blurView.topAnchor),
            dishImageView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
        ])
    }
    
    func setupBlurView() {
        contentView.addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func setupNameLabel() {
        contentView.addSubview(dishNameLabel)
        
        dishNameLabel.sizeToFit()
        
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            dishNameLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            dishNameLabel.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 20)
        ])
    }
    
    func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        
        priceLabel.sizeToFit()
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 6)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishImageView.image = nil
        dishNameLabel.text = nil
        priceLabel.text = nil
    }
    
}
