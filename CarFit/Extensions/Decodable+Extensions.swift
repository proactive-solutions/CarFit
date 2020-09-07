//
//  Decodable.swift
//  CarFit
//
//  Created by Pawan Sharma on 05/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation
//MARK: - JSON data decoding
extension Decodable {

    /// Decodes a JSON data into a Struct or class which conforms to Decodale protocol
    /// - Parameter data: JSON data
    /// - Returns: Decodes data model from JSON data, or throws an error
    static func decodeWith<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
