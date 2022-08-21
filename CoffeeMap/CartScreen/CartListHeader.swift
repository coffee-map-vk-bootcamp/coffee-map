//
//  CartListHeader.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

final class CartListHeader: UITableViewHeaderFooterView {
    
    private lazy var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = "Корзина"
        mainLabel.toAutoLayout()
        mainLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return mainLabel
    }()
    
    private lazy var nameOfCoffeeShop: UILabel = {
        let nameOfCoffeeShop = UILabel()
        nameOfCoffeeShop.text = "название кофейни"
        nameOfCoffeeShop.toAutoLayout()
        nameOfCoffeeShop.font = UIFont.systemFont(ofSize: 24)
        nameOfCoffeeShop.textColor = .systemGray4
        
        return nameOfCoffeeShop
    }()
    
    private lazy var textTimeLabel: UILabel = {
        let textTimeLabel = UILabel()
        textTimeLabel.text = "Приготовить к"
        textTimeLabel.font = UIFont.systemFont(ofSize: 16)
        textTimeLabel.textColor = .systemGreen
        textTimeLabel.toAutoLayout()
        
        return textTimeLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "12:00"
        timeLabel.toAutoLayout()
        timeLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        timeLabel.textColor = .systemGreen
        
        return timeLabel
    }()
     
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        addSubviews([mainLabel, nameOfCoffeeShop, timeLabel, textTimeLabel])
    }
    
    func configure(name: String) {
        nameOfCoffeeShop.text = name
    }
    
    private func layout() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            
            nameOfCoffeeShop.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            nameOfCoffeeShop.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 1),
            nameOfCoffeeShop.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            nameOfCoffeeShop.trailingAnchor.constraint(equalTo: textTimeLabel.leadingAnchor, constant: -10),
            
            textTimeLabel.topAnchor.constraint(equalTo: mainLabel.topAnchor),
            textTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            timeLabel.topAnchor.constraint(equalTo: textTimeLabel.topAnchor, constant: 18),
            timeLabel.trailingAnchor.constraint(equalTo: textTimeLabel.trailingAnchor),
        ])
    }
}
