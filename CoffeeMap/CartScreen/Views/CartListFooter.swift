//
//  CartListFooter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

protocol CartListFooterDelegate: AnyObject {
    func makeOrderDidTap()
}

final class CartListFooter: UIView {

    weak var delegate: CartListFooterDelegate?
    
    private lazy var sumLabel: UILabel = {
        let sumLabel = UILabel()
        sumLabel.text = "Итого"
        sumLabel.font = UIFont.systemFont(ofSize: 24)
        sumLabel.toAutoLayout()
        
        return sumLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "160₽"
        priceLabel.font = UIFont.systemFont(ofSize: 24)
        priceLabel.toAutoLayout()
        
        return priceLabel
    }()
    
    private lazy var buyButton: UIButton = {
        let buyButton = UIButton()
        buyButton.setTitle("Оплатить", for: .normal)
        buyButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        buyButton.setBackgroundColor(color: .primary, forState: .normal)
        buyButton.layer.cornerRadius = 16
        buyButton.clipsToBounds = true
        buyButton.toAutoLayout()
        
        return buyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(sumPrice: Int) {
        priceLabel.text = "\(sumPrice)₽"
    }
    
    private func setup() {
        addSubviews([sumLabel, priceLabel, buyButton])
        backgroundColor = .appTintColor
        
        sumLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            sumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            sumLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            priceLabel.topAnchor.constraint(equalTo: sumLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 24),
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])

        buyButton.addTarget(self, action: #selector(buyButtonDidTap), for: .touchUpInside)
    }

    @objc
    private func buyButtonDidTap() {
        delegate?.makeOrderDidTap()
    }
}
