//
//  CoffeeShopDetailHeaderView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

class CoffeeShopDetailHeaderView: UICollectionReusableView {
    private lazy var headerImageView: UIImageView = {
        let headerView = UIImageView()
        headerView.contentMode = .scaleAspectFill
        return headerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layoutHeader()
    }
    
    private func setup() {
        addSubview(headerImageView)
        clipsToBounds = true
    }
    
    private func layoutHeader() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage?) {
        headerImageView.image = image
    }
}
