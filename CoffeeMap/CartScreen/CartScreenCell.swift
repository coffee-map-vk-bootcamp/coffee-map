//
//  CartScreenCell.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

final class CartScreenCell: UITableViewCell {
    
    private lazy var dishImageView: SkeletonImageView = {
        let dishImageView = SkeletonImageView()
        dishImageView.layer.cornerRadius = 16
        dishImageView.clipsToBounds = true
        dishImageView.toAutoLayout()
        
        return dishImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Test"
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.toAutoLayout()
        
        return nameLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "80₽"
        //priceLabel.textColor = .systemGray2
        priceLabel.font = UIFont.systemFont(ofSize: 24)
        priceLabel.toAutoLayout()
        
        return priceLabel
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = "Количество"
        countLabel.textColor = .systemGray2
        countLabel.font = UIFont.systemFont(ofSize: 20)
        countLabel.toAutoLayout()
        
        return countLabel
    }()
    
    private lazy var countNumberLabel: UILabel = {
        let countNumberLabel = UILabel()
        countNumberLabel.text = "2"
        countNumberLabel.textColor = .systemGray2
        countNumberLabel.font = UIFont.systemFont(ofSize: 20)
        countNumberLabel.toAutoLayout()
        
        return countNumberLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        contentView.addSubviews([dishImageView, nameLabel, priceLabel, countLabel, countNumberLabel])
    }
    
    func configure(image: String, name: String, price: String, count: String) {
        nameLabel.text = name
        priceLabel.text = price
        countNumberLabel.text = count
        dishImageView.setImage(with: image)
    }
    
    private func layout() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
            
            nameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: dishImageView.topAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            countNumberLabel.topAnchor.constraint(equalTo: countLabel.topAnchor),
            countNumberLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
        ])
    }
}

