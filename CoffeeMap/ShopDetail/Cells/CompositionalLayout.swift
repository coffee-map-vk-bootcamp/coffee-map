//
//  CompositionalLayout.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 14.08.2022.
//

import UIKit

final class CompositionalLayout {
    static func createLayout(contentSize: CGSize,
                             output: CoffeeShopDetailScreenViewOutput,
                             interItemSpacing: CGFloat = 16) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            let numberOfItems = output.number(of: sectionNumber)
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .absolute(contentSize.width / 4), heightDimension: .absolute(180)))
            
            let cellWidth = CGFloat(numberOfItems * 100 + (numberOfItems - 1)) * interItemSpacing
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth), heightDimension: .estimated(180))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .some(.fixed(8))
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = interItemSpacing
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            return section
        }
//
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(150))
        
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Constants.HeaderKind.globalHeader, alignment: .top)
        globalHeader.pinToVisibleBounds = true
        globalHeader.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        config.boundarySupplementaryItems = [globalHeader]

        layout.configuration = config
        layout.configuration.interSectionSpacing = 16
        
        return layout
    }
}

struct Constants {
    struct HeaderKind {
        static let globalHeader = "com.CoffeeMap.globalHeader"
    }
}
