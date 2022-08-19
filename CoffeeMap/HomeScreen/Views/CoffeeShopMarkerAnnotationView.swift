//
//  CoffeeShopMarkerAnnotationView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//

import Foundation
import MapKit

final class CoffeeShopMarkerAnnotationView: MKMarkerAnnotationView {
    static var clusteringIdentifier: String {
        NSStringFromClass(self)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = Self.clusteringIdentifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = .init(hex: "4CB17D")
        glyphImage = .init(named: AppImageNames.mapPin)
    }
}
