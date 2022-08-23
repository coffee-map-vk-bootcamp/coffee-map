//
//  CoffeeShopClusterAnnotation.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 19.08.2022.
//

import MapKit

class CoffeeShopClusterAnnotation: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        collisionMode = .circle
        tintColor = .init(hex: "4CB17D")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
