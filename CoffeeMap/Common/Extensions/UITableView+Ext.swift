//
//  UITableView+Ext.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Can't dequeue reusable cell for \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
