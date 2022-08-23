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
        nameOfCoffeeShop.textColor = .systemGray2
        
        return nameOfCoffeeShop
    }()
    
    private lazy var textTimeLabel: UILabel = {
        let textTimeLabel = UILabel()
        textTimeLabel.text = "Приготовить к"
        textTimeLabel.font = UIFont.systemFont(ofSize: 24)
        textTimeLabel.textColor = .primary
        textTimeLabel.toAutoLayout()
        
        return textTimeLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        datePicker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .inline
        datePicker.toAutoLayout()
        
        return datePicker
    }()
         
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        backgroundColor = .white
        contentView.addSubviews([mainLabel, nameOfCoffeeShop, datePicker, textTimeLabel])
    }
    
    func configure(name: String) {
        nameOfCoffeeShop.text = name
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            nameOfCoffeeShop.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameOfCoffeeShop.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 2),
            nameOfCoffeeShop.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            textTimeLabel.topAnchor.constraint(equalTo: nameOfCoffeeShop.bottomAnchor, constant: 8),
            textTimeLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            textTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            datePicker.centerYAnchor.constraint(equalTo: textTimeLabel.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: textTimeLabel.trailingAnchor, constant: 4),
        ])
    }
}
