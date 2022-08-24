//
//  CartScreenCell.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//

import Foundation
import UIKit

final class CartScreenCell: UITableViewCell {
    var deleteAction: (() -> Void)?
    
    var isDelete: Bool = false
    
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
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.toAutoLayout()
        
        return nameLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "80₽"
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.textAlignment = .right
        priceLabel.toAutoLayout()
        
        return priceLabel
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = "Количество"
        countLabel.textColor = .systemGray2
        countLabel.font = UIFont.systemFont(ofSize: 18)
        countLabel.toAutoLayout()
        
        return countLabel
    }()
    
    private lazy var countNumberLabel: UILabel = {
        let countNumberLabel = UILabel()
        countNumberLabel.text = "2"
        countNumberLabel.textColor = .systemGray2
        countNumberLabel.font = UIFont.systemFont(ofSize: 18)
        countNumberLabel.textAlignment = .right
        countNumberLabel.toAutoLayout()
        
        return countNumberLabel
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteDish), for: .touchUpInside)
        deleteButton.contentMode = .scaleAspectFit
        deleteButton.toAutoLayout()
        
        return deleteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubviews([dishImageView, nameLabel, priceLabel, countLabel, countNumberLabel, deleteButton])
    }
    
    func configure(image: String, name: String, price: String, count: String, deleteAction: @escaping () -> Void) {
        nameLabel.text = name
        priceLabel.text = "\(price) ₽"
        countNumberLabel.text = count
        dishImageView.setImage(with: image)
        self.deleteAction = deleteAction
    }
    
    private func layout() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            nameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: dishImageView.topAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),

            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            
            countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            countNumberLabel.topAnchor.constraint(equalTo: countLabel.topAnchor),
            countNumberLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor)
        ])

        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    @objc
    private func deleteDish() {
        deleteAction?()
    }
}
