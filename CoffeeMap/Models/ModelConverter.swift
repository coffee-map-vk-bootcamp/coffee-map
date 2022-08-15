//
//  ModelConverter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 14.08.2022.
//

import Foundation
import Firebase

final class ModelConverter {
    
    static let decoder = JSONDecoder()
    
    static func convert<T: Decodable>(from fbData: QueryDocumentSnapshot) throws -> T {
        let dataCollection = fbData.data()
        let data = try JSONSerialization.data(withJSONObject: dataCollection, options: .prettyPrinted)
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }
}
