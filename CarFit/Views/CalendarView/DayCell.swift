//
//  DayCell.swift
//  Calendar
//
//  Test Project
//

import UIKit

/// Represents a day in the Calendar view. Displays day and weekday for the day being represented.
final class DayCell: UICollectionViewCell {

    @IBOutlet private weak var dayView: UIView!
    @IBOutlet private weak var day: UILabel!
    @IBOutlet private weak var weekday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayView.layer.cornerRadius = self.dayView.frame.width / 2.0
        self.dayView.backgroundColor = .clear
    }

    /// Displays date, weekday and marks the day selected if current date is same is date being shown.
    /// - Parameters:
    ///   - _day: day of the month
    ///   - dayOfWeek: week day
    ///   - isCurrentDay: true if today's date otherwise false. Highlighted in cirucular view if value of isCurrentDay is `true`
    func display(day _day: Int, dayOfWeek: String, isCurrentDay: Bool) {
        day.text = "\(_day)"
        weekday.text = dayOfWeek
        dayView.backgroundColor = isCurrentDay ? .daySelected : .clear
    }
}
