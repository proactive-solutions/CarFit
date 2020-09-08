//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: String)
}

final class CalendarView: UIView {
    @IBOutlet private weak var monthAndYear: UILabel!
    @IBOutlet private weak var leftBtn: UIButton!
    @IBOutlet private weak var rightBtn: UIButton!
    @IBOutlet private weak var daysCollectionView: UICollectionView!

    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    private let calendarViewModel = CalendarViewModel()

    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.daysCollectionView.register(nib, forCellWithReuseIdentifier: self.cellID)
        self.daysCollectionView.delegate = self
        self.daysCollectionView.dataSource = self
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
    }
    
    //MARK:- Change month when left and right arrow button tapped
    @IBAction private func leftArrowTapped(_ sender: UIButton) {
        if (calendarViewModel.month > 1) {
            calendarViewModel.month -= 1
        } else {
            calendarViewModel.month = 12
            calendarViewModel.year -= 1
        }
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
        daysCollectionView.reloadData()
    }

    @IBAction private func rightArrowTapped(_ sender: UIButton) {
        if (calendarViewModel.month < 12) {
            calendarViewModel.month += 1
        } else {
            calendarViewModel.month = 1
            calendarViewModel.year += 1
        }
        monthAndYear.text = "\(calendarViewModel.monthTitle) \(calendarViewModel.year)"
        daysCollectionView.reloadData()
   }
}

//MARK:- Calendar collection view delegate and datasource methods
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarViewModel.numberOfDays()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! DayCell
        cell.display(
            day: indexPath.item + 1,
            dayOfWeek: calendarViewModel.dayOfWeek(day: indexPath.item + 1),
            isCurrentDay: calendarViewModel.isCurrentDate(day: indexPath.item + 1)
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.getSelectedDate(calendarViewModel.dateString_yyyy_MM_dd(withDay: indexPath.item + 1))
    }
}

//MARK:- Add calendar to the view
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
