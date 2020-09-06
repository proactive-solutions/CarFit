//
//  ViewController.swift
//  Calendar
//
//  Test Project
//

import UIKit

final class HomeViewController: UIViewController, AlertDisplayer {
    @IBOutlet private var navBar: UINavigationBar!
    @IBOutlet private var calendarView: UIView!
    @IBOutlet private var calendar: UIView!
    @IBOutlet private var calendarButton: UIBarButtonItem!
    @IBOutlet private var workOrderTableView: TableView!

    private let cellID = "HomeTableViewCell"

    private let cleanerListViewModel = CleanerListViewModel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
        self.addPullToRefresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
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

    private func addPullToRefresh() {
        self.workOrderTableView.onRefresh { [weak self] in
            guard let self = self else { return }
            self.cleanerListViewModel.getVisits()
            self.workOrderTableView.reloadData()
            self.workOrderTableView.endRefresh()
        }
    }

    // MARK: - Show calendar when tapped, Hide the calendar when tapped outside the calendar view
    @IBAction private func calendarTapped(_ sender: UIBarButtonItem) {}
}

// MARK: - Tableview delegate and datasource methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cleanerListViewModel.visits?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! HomeTableViewCell

        if let data = cleanerListViewModel.visits?.data[indexPath.row] {
            cell.display(details: VisitsDataModel(with: data))
        }

        return cell
    }
}

// MARK: - Get selected calendar date
extension HomeViewController: CalendarDelegate {
    func getSelectedDate(_ date: String) {

    }
}
