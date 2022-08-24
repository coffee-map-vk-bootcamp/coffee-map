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

protocol CartListFooterDescription {
    var orderTime: Date { get }
}

final class CartListFooter: UIView {

    weak var delegate: CartListFooterDelegate?
    
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
    
    private lazy var textTimeLabel: UILabel = {
        let textTimeLabel = UILabel()
        textTimeLabel.text = "Приготовим к"
        textTimeLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        textTimeLabel.textColor = .primary
        textTimeLabel.toAutoLayout()
        
        return textTimeLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        datePicker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = NSLocale(localeIdentifier: "ru_RU") as Locale
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .inline
        datePicker.toAutoLayout()
        
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(sumPrice: Int) {
        buyButton.isEnabled = sumPrice != 0
        buyButton.setTitle("Оплатить \(sumPrice) ₽", for: .normal)
    }
    
    private func setup() {
        addSubviews([buyButton, textTimeLabel, datePicker])
        backgroundColor = .appTintColor
        
        NSLayoutConstraint.activate([
            
            textTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textTimeLabel.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -16),
            
            datePicker.centerYAnchor.constraint(equalTo: textTimeLabel.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: textTimeLabel.trailingAnchor, constant: 4),
            
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        buyButton.addTarget(self, action: #selector(buyButtonDidTap), for: .touchUpInside)
    }

    @objc
    private func buyButtonDidTap() {
        delegate?.makeOrderDidTap()
    }
}

extension CartListFooter: CartListFooterDescription {
    var orderTime: Date {
        datePicker.date
    }
}
