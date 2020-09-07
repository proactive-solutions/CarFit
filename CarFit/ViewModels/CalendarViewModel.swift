//
//  CalendarViewModel.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

final class CalendarViewModel {
    private let calendar = Calendar.current
    private let todaysDate = Date()
    private let dateFormatter = DateFormatter()

    var month = Date().get(components: .month).month ?? 1
    var year = Date().get(components: .year).year ?? 2020

    var monthTitle: String {
        Constants.monthNames[month - 1]
    }

    func isCurrentDate(day: Int) -> Bool {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "\(year)-\(month)-\(day)")
        let todayDate = Date()
        let strValue = dateFormatter.string(from: todayDate)
        let date2 = dateFormatter.date(from: strValue)
        return date == date2
    }

    func dayOfWeek(day: Int) -> String {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone.current

        let todayDate = Date()
        dateFormatter.dateFormat = "HH"
        dateComponents.hour = Int(dateFormatter.string(from: todayDate))
        dateFormatter.dateFormat = "mm"
        dateComponents.minute = Int(dateFormatter.string(from: todayDate))

        let someDateTime = Calendar.current.date(from: dateComponents)
        let weekDay = calendar.component(.weekday, from: someDateTime!)
        return  Constants.weekdayName[weekDay - 1]
    }

    func numberOfDaysIn() -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return  numDays
    }
}
