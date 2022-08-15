//
//  DishCollectionViewCell.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import UIKit
import Kingfisher

final class DishCollectionViewCell: UICollectionViewCell {
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .dishItemName
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .dishItemName
        return label
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 4
        blurView.layer.masksToBounds = true
        return blurView
    }()
    
    private lazy var dishImageView = UIImageView()
    
    private lazy var selectedBlurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 4
        blurView.layer.masksToBounds = true
        blurView.alpha = 0.75
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: Dish) {
        dishImageView.image = UIImage(named: AppImageNames.mockDishImage1)?.kf.blurred(withRadius: 30)
        dishNameLabel.text = dish.name
        priceLabel.text = "\(dish.price) ₽"
//        isDishSelected = dish.isSelected
    }
    
    override func layoutSubviews() {
//        layoutBlurView()
        layoutDishImageView()
        layoutNameLabel()
        layoutPriceLabel()
//        layoutSelectedBlurView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishImageView.image = nil
        dishNameLabel.text = nil
        priceLabel.text = nil
        blurView.effect = nil
        
    }
    
}

private extension DishCollectionViewCell {
    func setupViews() {
        [priceLabel, dishNameLabel, blurView, dishImageView, selectedBlurView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupDishImageView() {
        dishImageView.contentMode = .scaleAspectFit
    }
    
    func layoutDishImageView() {
        dishImageView.translatesAutoresizingMaskIntoConstraints = false

        dishImageView.sizeToFit()

        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: topAnchor),
            dishImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dishImageView.heightAnchor.constraint(equalToConstant: 95),
            dishImageView.widthAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func layoutBlurView() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 95),
            blurView.widthAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func layoutNameLabel() {
        dishNameLabel.sizeToFit()
        
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            dishNameLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            dishNameLabel.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 20)
        ])
    }
    
    func layoutPriceLabel() {
        priceLabel.sizeToFit()
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 6)
        ])   
    }
    
    func layoutSelectedBlurView() {
        selectedBlurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedBlurView.topAnchor.constraint(equalTo: blurView.topAnchor),
            selectedBlurView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            selectedBlurView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            selectedBlurView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
        ])
    }
}
