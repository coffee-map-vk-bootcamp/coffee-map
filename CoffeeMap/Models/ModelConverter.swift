//
//  ModelConverter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 14.08.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

final class ModelConverter {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    static func convert<T: Decodable>(from fbData: DocumentSnapshot) throws -> T {
        guard let dataCollection = fbData.data() else {
            throw FireBaseError.receivedNilData
        }
        let data = try JSONSerialization.data(withJSONObject: dataCollection, options: .prettyPrinted)
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }
}
