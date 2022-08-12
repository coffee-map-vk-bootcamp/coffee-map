//
//  CoffeeShopDetailCollectionViewCell.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 09.08.2022.
//

import UIKit

protocol CoffeeShopDetailCollectionDelegate: AnyObject {
    func didSelect(with item: Dish)
}

final class CoffeeShopDetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var sectionTitle = UILabel()
    
    private lazy var horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dishes: [Dish] = []
    
    weak var delegate: CoffeeShopDetailCollectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSectionTitle()
        setupCollectionView()
        
        layoutSectionTitle()
        layoutCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sectionTitle.text = nil
    }
    
    func configure(with section: DishSection, delegate: CoffeeShopDetailCollectionDelegate) {
        sectionTitle.text = section.sectionTitle
        dishes = section.dishes
        self.delegate = delegate
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
        
        horizontalCollectionView.collectionViewLayout = layout
        
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
        horizontalCollectionView.register(DishCollectionViewCell.self)
        
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(horizontalCollectionView)
    }
    
    func layoutSectionTitle() {
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            sectionTitle.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func layoutCollectionView() {
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalCollectionView.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor, constant: 0),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension CoffeeShopDetailCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 24, bottom: 0, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalPadding: CGFloat = 16
        let spacing: CGFloat = 16
        let numberOfRows: CGFloat = 3
        
        let offset = horizontalPadding * 2 + spacing * (numberOfRows - 1)
        let width = (frame.size.width - offset) / numberOfRows
        
        return .init(width: width * 0.95, height: 160)
    }
}

extension CoffeeShopDetailCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(DishCollectionViewCell.self, for: indexPath)
        
        let model = dishes[indexPath.item]
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = dishes[indexPath.item]
        delegate?.didSelect(with: dish)
    }
}
