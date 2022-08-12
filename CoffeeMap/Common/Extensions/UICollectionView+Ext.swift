//
//  UICollectionView+Ext.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind elementKind: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Can't dequeueReusableCell for \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ cellClass: T.Type,
                                                                       ofKind elementKind: String,
                                                                       for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Can't dequeueReusableCell for \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
