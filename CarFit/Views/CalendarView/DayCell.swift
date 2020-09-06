//
//  DayCell.swift
//  Calendar
//
//  Test Project
//

import UIKit

final class DayCell: UICollectionViewCell {

    @IBOutlet private weak var dayView: UIView!
    @IBOutlet private weak var day: UILabel!
    @IBOutlet private weak var weekday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayView.layer.cornerRadius = self.dayView.frame.width / 2.0
        self.dayView.backgroundColor = .clear
    }

    func display(day _day: Int, dayOfWeek: String) {
        day.text = "\(_day + 1)"
        weekday.text = dayOfWeek
    }
}
