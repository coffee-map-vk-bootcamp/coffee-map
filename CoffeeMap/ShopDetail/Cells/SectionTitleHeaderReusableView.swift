//
//  SectionTitleHeaderReusableView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 15.08.2022.
//

import UIKit

final class SectionTitleHeaderReusableView: UICollectionReusableView {
    private lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layoutSectionTitle()
    }
    
    func configure(with text: String) {
        sectionTitle.text = text
    }
    
    private func setup() {
        addSubview(sectionTitle)
        
    }
    
    private func layoutSectionTitle() {
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: topAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            sectionTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
