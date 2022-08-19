//
//  MKMarkerAnnotationView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 18.08.2022.
//

import MapKit

extension MKMarkerAnnotationView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
