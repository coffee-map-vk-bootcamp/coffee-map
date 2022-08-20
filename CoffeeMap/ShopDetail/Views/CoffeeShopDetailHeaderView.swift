//
//  CoffeeShopDetailHeaderView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

class CoffeeShopDetailHeaderView: UICollectionReusableView {
    private lazy var headerImageView: SkeletonImageView = {
        let headerView = SkeletonImageView()
        headerView.contentMode = .scaleAspectFill
        return headerView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.75).cgColor]
        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        headerImageView.layer.addSublayer(gradientLayer)
        headerImageView.frame = bounds
        gradientLayer.frame = headerImageView.bounds
        addSubview(headerImageView)
        clipsToBounds = true
    }
    
    func configure(with imageUrlString: String) {
        headerImageView.setImage(with: imageUrlString)
    }
}
