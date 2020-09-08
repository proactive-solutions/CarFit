//
//  Set+Extension.swift
//  CarFit
//
//  Created by Pawan Sharma on 08/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension Set {
    mutating func append(element: Element) {
        var aray = [Element](self)
        aray.append(element)
        self.removeAll()
        self = Set<Element>(aray)
    }

    mutating func removeFirstAndAppend(element: Element) {
        var aray = [Element](self)
        aray.removeFirst()
        aray.append(element)
        self.removeAll()
        self = Set<Element>(aray)
    }
}
