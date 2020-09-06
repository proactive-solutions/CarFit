//
//  Decodable.swift
//  CarFit
//
//  Created by Pawan Sharma on 05/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension Decodable {
    static func decodeWith<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
