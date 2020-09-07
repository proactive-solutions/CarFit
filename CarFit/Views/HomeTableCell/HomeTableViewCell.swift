//
//  HomeTableViewCell.swift
//  Calendar
//
//  Test Project
//

import UIKit
import CoreLocation

/// Represents Work Order Table view cell instance
final class HomeTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var customer: UILabel!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var tasks: UILabel!
    @IBOutlet private weak var arrivalTime: UILabel!
    @IBOutlet private weak var destination: UILabel!
    @IBOutlet private weak var timeRequired: UILabel!
    @IBOutlet private weak var distance: UILabel!

    //MARK: - View Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10.0
        statusView.layer.cornerRadius = status.frame.height / 2.0
        statusView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
    }

    /// Displays visit details
    /// - Parameters:
    ///   - visit: VisitsDataModel instance for providing all the information in required format
    ///   - previousVistiLocation: Location of previous visit. Used to calculate distance between current visit and previous visit.
    func display(visit: VisitsDataModel, previousVistiLocation: CLLocation?) {
        customer.text = visit.fullName
        destination.text = visit.location
        let _status = visit.visitStatus
        status.text = _status.rawValue.uppercased()
        statusView.backgroundColor = _status.backgroundColor()
        arrivalTime.text = visit.expectedTime ?? "Unknown"
        timeRequired.text = "\(visit.requiredTime()) min"
        tasks.text = visit.taskDescription()

        if let prevLocation = previousVistiLocation {
            distance.text = String(format: "%0.2f KM", visit.distanceFrom(previousLocation: prevLocation))
        } else {
            distance.text = "0.0"
        }
    }
}
