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
    
    private lazy var dishNameLabel = UILabel()
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
}

private extension DishConfigurationAlertView {
    func setup() {
        let views = [dishImageView, dishNameLabel, priceLabel, amountLabel,
                     sugarAmountLabel, sizeLabel, dismissButton, addToCartButton]
        
        addSubviews(views)
        backgroundColor = .systemBackground
        layout()
        
        layer.cornerRadius = 10
    }
    
    func layout() {
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dishImageView.heightAnchor.constraint(equalToConstant: 88),
            dishImageView.widthAnchor.constraint(equalToConstant: 88)
        ])
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 16),
            dismissButton.widthAnchor.constraint(equalToConstant: 16)
        ])
        
        dismissButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    @objc func didTapClose() {
        delegate?.didTapClose()
    }
}
