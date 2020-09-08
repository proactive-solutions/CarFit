//
//  ViewController.swift
//  Calendar
//
//  Test Project
//

import CoreLocation
import UIKit

final class HomeViewController: UIViewController, AlertDisplayer {
    @IBOutlet private var navBar: UINavigationBar!
    @IBOutlet private var calendarView: UIView!
    @IBOutlet private var calendar: UIView!
    @IBOutlet private var calendarButton: UIBarButtonItem!
    @IBOutlet private var workOrderTableView: RefreshableTableView!
    @IBOutlet private var calendarViewHeight: NSLayoutConstraint!
    private let cellID = "HomeTableViewCell"
    private var visits = [VisitsData]() {
        didSet {
            workOrderTableView.reloadData()
        }
    }

    /// Tap gesture on tab view to hide the calendar view
    private let tapGesture = UITapGestureRecognizer()
    private let cleanerListViewModel = CleanerListViewModel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
        self.addPullToRefreshOnTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTapGesureOnTableView()
        visits = cleanerListViewModel.getVisits()
    }

    // MARK: - Add calender to view
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendar) {
            calendar.delegate = self
        }
    }

    // MARK: - UI setups
    private func setupUI() {
        self.navBar.transparentNavigationBar()
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.workOrderTableView.register(nib, forCellReuseIdentifier: self.cellID)
        self.workOrderTableView.rowHeight = UITableView.automaticDimension
        self.workOrderTableView.estimatedRowHeight = 170
    }

    // MARK: - Table view seups
    private func addTapGesureOnTableView() {
        tapGesture.addTarget(self, action: #selector(toggleCalendarviewAppearance))
        workOrderTableView.addGestureRecognizer(tapGesture)
        // Initially disable the tap gesture on the table view to stop showing the calendar when the user taps on the workOrderTableView.
        // If this is not disable then tapping multiple times on the work workOrderTableView will hide and show the calendar view.
        tapGesture.isEnabled = false
    }

    private func addPullToRefreshOnTableView() {
        self.workOrderTableView.onRefresh { [weak self] in
            guard let self = self else { return }
            self.visits = self.cleanerListViewModel.getVisits()
            self.workOrderTableView.endRefresh()
        }
    }

    /// Toggles calendar view apperance with animation
    @objc private func toggleCalendarviewAppearance() {
        tapGesture.isEnabled.toggle()
        calendarViewHeight.constant = calendarViewHeight.constant >= 200 ? 0.0 : 200.0
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - Show calendar when tapped, Hide the calendar when tapped outside the calendar view
    @IBAction private func calendarTapped(_ sender: UIBarButtonItem) {
        toggleCalendarviewAppearance()
    }
}

// MARK: - Tableview delegate and datasource methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! HomeTableViewCell

        let data = self.visits[indexPath.row]
        if (indexPath.row == 0) {
            cell.display(visit: VisitsDataModel(with: data), previousVistiLocation: nil)
        } else {
            let previousVisitData = self.visits[indexPath.row - 1]
            let prevVisitLocation = CLLocation(
                latitude: previousVisitData.houseOwnerLatitude,
                longitude: previousVisitData.houseOwnerLongitude
            )
            cell.display(
                visit: VisitsDataModel(with: data),
                previousVistiLocation: prevVisitLocation
            )
        }

        return cell
    }
}

// MARK: - Get selected calendar date
extension HomeViewController: CalendarDelegate {
    func getSelectedDates(_ selectedDates: Set<String>) {
        var visitsOnSelectedDate = [VisitsData]()
        for selectedDate in selectedDates {
            visitsOnSelectedDate += self.cleanerListViewModel.getVisitsOn(date: selectedDate)
        }
        print(selectedDates)
        self.visits = visitsOnSelectedDate
    }
}
