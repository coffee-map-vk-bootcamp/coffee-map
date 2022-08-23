//
//  DishConfigurationAlertView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 22.08.2022.
//

import UIKit

protocol DishConfigurationAlertViewDelegate: AnyObject {
    func didTapClose()
}

final class DishConfigurationAlertView: UIView {
    weak var delegate: DishConfigurationAlertViewDelegate?
    
    private lazy var dishImageView = SkeletonImageView()
    
    private lazy var dishNameLabel = UILabel(text: "Название продукта",
                                             font: .systemFont(ofSize: 18, weight: .semibold),
                                             color: .init(hex: "3F3E3E"))
    private lazy var priceLabel = UILabel(text: "80,00 ₽",
                                          font: .systemFont(ofSize: 22, weight: .bold),
                                          color: .secondaryLabel)
    
    private lazy var amountLabel = UILabel(text: "Количество",
                                           font: .systemFont(ofSize: 14, weight: .medium),
                                           color: .secondaryLabel)
    
    private lazy var sugarAmountLabel = UILabel()
    private lazy var sizeLabel = UILabel(text: "Размер",
                                         font: .systemFont(ofSize: 14, weight: .medium),
                                         color: .secondaryLabel)
    
    private lazy var dismissButton = UIButton(type: .close)
    private lazy var addToCartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.setImage(with: dish.image)
        priceLabel.text = "\(dish.price) ₽"
    }
}

private extension DishConfigurationAlertView {
    func setup() {
        let views = [dishImageView, dishNameLabel, priceLabel, amountLabel,
                     sugarAmountLabel, sizeLabel, dismissButton, addToCartButton]
        
        addSubviews(views)
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        setupIntial()
        setupDishImageView()
        setupDismissButton()
    }
    
    func setupIntial() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
    }
    
    func setupDishImageView() {
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishImageView.layer.cornerRadius = 16
    }
    
    func setupDismissButton() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    func layout() {
        layoutDishImageView()
        layoutDismissButton()
        layoutDishNameLabel()
    }
    
    func layoutDishNameLabel() {
        dishNameLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 22),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            dishNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 34)
        ])
    }
    
    func layoutDishImageView() {
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            dishImageView.heightAnchor.constraint(equalToConstant: 88),
            dishImageView.widthAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    func layoutDismissButton() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 16),
            dismissButton.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    @objc func didTapClose() {
        delegate?.didTapClose()
    }
}
