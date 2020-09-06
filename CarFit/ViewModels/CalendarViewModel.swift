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

    private let monthNames = [
        "Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec",
    ]

    private let weekdayName = [
        "Sun", "Mon", "Tue",
        "Wed", "Thu","Fri", "Sat"
    ]

    var month = Date().get(components: .month).month ?? 1
    var year = Date().get(components: .year).year ?? 2020

    var monthTitle: String {
        monthNames[month - 1]
    }

    func dayOfWeek(day: Int) -> String {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone.current
        let someDateTime = Calendar.current.date(from: dateComponents)
        let weekDay = calendar.component(.weekday, from: someDateTime!)
        return weekdayName[weekDay - 1]
    }

    func numberOfDaysIn() -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return  numDays
    }
}
