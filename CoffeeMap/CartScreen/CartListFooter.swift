//
//  CartListFooter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

final class CartListFooter: UIView {
    
    private lazy var sumLabel: UILabel = {
        let sumLabel = UILabel()
        sumLabel.text = "Итого"
        sumLabel.font = UIFont.systemFont(ofSize: 28)
        sumLabel.toAutoLayout()
        
        return sumLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "160₽"
        priceLabel.font = UIFont.systemFont(ofSize: 28)
        priceLabel.toAutoLayout()
        
        return priceLabel
    }()
    
    private lazy var buyButton: UIButton = {
        let buyButton = UIButton()
        buyButton.setTitle("Оплатить", for: .normal)
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        buyButton.backgroundColor = .systemGreen
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
    
    func configure(sumPrice: Int){
        priceLabel.text = "\(sumPrice)₽"
    }
    
    private func setup(){
        addSubviews([sumLabel, priceLabel, buyButton])
        backgroundColor = .appTintColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            sumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            sumLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            priceLabel.topAnchor.constraint(equalTo: sumLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
            buyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.widthAnchor.constraint(equalToConstant: 330),
        ])
    }
}
