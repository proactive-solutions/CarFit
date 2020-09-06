//
//  DateFormatter+Extension.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension Date {
    func get(components: Calendar.Component...) -> DateComponents {
        Calendar.current.dateComponents(Set(components), from: self)
    }
}
