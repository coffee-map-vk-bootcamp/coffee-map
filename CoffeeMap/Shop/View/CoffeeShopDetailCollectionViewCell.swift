//
//  CoffeeShopDetailCollectionViewCell.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

final class CoffeeShopDetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var sectionTitle = UILabel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSectionTitle()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSectionTitle()
        layoutCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sectionTitle.text = nil
    }
    
    func configure(title: String) {
        sectionTitle.text = title
    }
}

private extension CoffeeShopDetailCollectionViewCell {
    func setupSectionTitle() {
        sectionTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        contentView.addSubview(sectionTitle)
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DishCollectionViewCell.self)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(collectionView)
    }
    
    func layoutSectionTitle() {
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            sectionTitle.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func layoutCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CoffeeShopDetailCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 24, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 16
        let numberOfRows: CGFloat = 3
        
        let offset = padding * 2 + spacing * numberOfRows
        let width = (frame.size.width - offset) / numberOfRows
        
        return .init(width: width, height: 170)
    }
    
}

extension CoffeeShopDetailCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(DishCollectionViewCell.self, for: indexPath)
        
        cell.dishNameLabel.text = "Название товара"
        cell.priceLabel.text = "80.00₽"
        
        return cell
    }
    
}
