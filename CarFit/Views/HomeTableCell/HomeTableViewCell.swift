//
//  HomeTableViewCell.swift
//  Calendar
//
//  Test Project
//

import UIKit
import CoreLocation

final class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var customer: UILabel!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var tasks: UILabel!
    @IBOutlet private weak var arrivalTime: UILabel!
    @IBOutlet private weak var destination: UILabel!
    @IBOutlet private weak var timeRequired: UILabel!
    @IBOutlet private weak var distance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10.0
        statusView.layer.cornerRadius = status.frame.height / 2.0
        statusView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
    }

    func display(details: VisitsDataModel) {
        customer.text = details.fullName
        destination.text = details.location
        let _status = details.visitStatus
        status.text = _status.rawValue.uppercased()
        statusView.backgroundColor = _status.color()
        arrivalTime.text = details.expectedTime ?? "Unknown"
        timeRequired.text = "\(details.requiredTime()) min"
        tasks.text = details.taskDescription()
    }
}
