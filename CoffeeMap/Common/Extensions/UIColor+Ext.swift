//
//  UIColor+Ext.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 10.08.2022.
//

import UIKit

extension UIColor {
    static let primary = UIColor(hex: "49B17E")
    static let secondaryBackground = UIColor(hex: "FBFBFB")
    static let borderColor = UIColor(hex: "E8E8E8")
    
    static let primaryTextColor = UIColor(hex: "#4F4F4F")
    
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            self.init(white: 0, alpha: 1.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(displayP3Red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
    
    static var appTintColor: UIColor = {
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            } else {
                return UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0)
            }
        }
    }()
    
    static var appTextColor: UIColor = {
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            } else {
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            }
        }
    }()
}
