//
//  DateFormatter+Extension.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension Date {

    /// Returns requested date components for the current calendar of the date
    /// - Parameter components: components required by the caller
    /// - Returns: Date components of the date
    func get(components: Calendar.Component...) -> DateComponents {
        Calendar.current.dateComponents(Set(components), from: self)
    }

    func getDateString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
