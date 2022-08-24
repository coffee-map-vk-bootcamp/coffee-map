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

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }()
    
    static func convert<T: Decodable>(from fbData: DocumentSnapshot) throws -> T {
        guard let dataCollection = fbData.data() else {
            throw FirebaseError.receivedNilData
        }
        let data = try JSONSerialization.data(withJSONObject: dataCollection, options: .prettyPrinted)
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }

    static func convert<T: Encodable>(from object: T) throws -> [String: Any] {
        let data = try encoder.encode(object)
        let json = try JSONSerialization.jsonObject(with: data)
        guard let dictionary = json as? [String: Any] else {
            return [:]
        }

        return dictionary
    }
}
