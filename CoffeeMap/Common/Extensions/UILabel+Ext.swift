//
//  UILabel+Ext.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 22.08.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, color: UIColor, numberOfLines: Int = 1) {
        self.init()
        
        self.text = text
        self.font = font
        textColor = color
        self.numberOfLines = numberOfLines
    }
}
