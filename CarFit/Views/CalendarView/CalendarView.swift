//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import UIKit

protocol CalendarDelegate: class {
    func getSelectedDates(_ date: Set<String>)
}

final class CalendarView: UIView {
    @IBOutlet private var monthAndYear: UILabel!
    @IBOutlet private var leftBtn: UIButton!
    @IBOutlet private var rightBtn: UIButton!
    @IBOutlet private var daysCollectionView: UICollectionView!

    /// Holds selected dates
    private var selectedDates: Set<String> = [Date().getDateString()]

    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    private let calendarViewModel = CalendarViewModel()

    // MARK: - Initialize calendar

    private func initialize() {
        let nib = UINib(nibName: cellID, bundle: nil)
        daysCollectionView.register(nib, forCellWithReuseIdentifier: cellID)
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
    }

    // MARK: - Change month when left and right arrow button tapped

    @IBAction private func leftArrowTapped(_ sender: UIButton) {
        if calendarViewModel.month > 1 {
            calendarViewModel.month -= 1
        } else {
            calendarViewModel.month = 12
            calendarViewModel.year -= 1
        }
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
        daysCollectionView.reloadData()
    }

    @IBAction private func rightArrowTapped(_ sender: UIButton) {
        if calendarViewModel.month < 12 {
            calendarViewModel.month += 1
        } else {
            calendarViewModel.month = 1
            calendarViewModel.year += 1
        }
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
        daysCollectionView.reloadData()
    }
}

// MARK: - Calendar collection view delegate and datasource methods

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarViewModel.numberOfDays()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DayCell
        let dateString = calendarViewModel.dateString_yyyy_MM_dd(withDay: indexPath.item + 1)
        cell.display(
            day: indexPath.item + 1,
            dayOfWeek: calendarViewModel.dayOfWeek(day: indexPath.item + 1),
            isSelectedDate: selectedDates.contains(dateString)
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDate = calendarViewModel.dateString_yyyy_MM_dd(withDay: indexPath.item + 1)
        if selectedDates.count < 2 {
            selectedDates.append(element: selectedDate)
        } else if selectedDates.contains(selectedDate) {
            selectedDates.remove(selectedDate)
        } else {
            selectedDates.removeFirstAndAppend(element: selectedDate)
        }
        delegate?.getSelectedDates(selectedDates)
        collectionView.reloadData()
    }
}

// MARK: - Add calendar to the view

extension CalendarView {
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
}
