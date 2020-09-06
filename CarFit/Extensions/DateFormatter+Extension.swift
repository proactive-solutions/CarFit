//
//  DateFormatter+Extension.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension DateFormatter {
    func displayTime(utcString: String) -> String {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let localDate = self.date(from: utcString) else {
            return "N/A"
        }

        self.dateFormat = "HH:mm"
        return self.string(from: localDate)
    }

    func displayDate(utcString: String) -> String {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let localDate = self.date(from: utcString) else {
            return "N/A"
        }

        self.dateFormat = "yyyy-MM-dd"
        return self.string(from: localDate)
    }
}
