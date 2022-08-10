//
//  CoffeeShopDetailHeaderView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

class CoffeeShopDetailHeaderView: UICollectionReusableView {
    lazy var headerImageView: UIImageView = {
        let headerView = UIImageView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.contentMode = .scaleAspectFill
        return headerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerImageView)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
