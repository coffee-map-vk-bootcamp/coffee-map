//
//  CartListHeader.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

final class CartListHeader: UITableViewHeaderFooterView {
    
    private lazy var nameOfCoffeeShop: UILabel = {
        let nameOfCoffeeShop = UILabel()
        nameOfCoffeeShop.text = "название кофейни"
        nameOfCoffeeShop.toAutoLayout()
        nameOfCoffeeShop.font = UIFont.systemFont(ofSize: 22)
        nameOfCoffeeShop.textColor = .systemGray2

        return nameOfCoffeeShop
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
        contentView.backgroundColor = .appTintColor
        backgroundColor = .white
        contentView.addSubview(nameOfCoffeeShop)
    }

    func configure(name: String) {
        nameOfCoffeeShop.text = name
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            nameOfCoffeeShop.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameOfCoffeeShop.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameOfCoffeeShop.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameOfCoffeeShop.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
