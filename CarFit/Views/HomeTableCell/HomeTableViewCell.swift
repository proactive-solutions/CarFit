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
        self.bgView.layer.cornerRadius = 10.0
        self.statusView.layer.cornerRadius = self.status.frame.height / 2.0
        self.statusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

}
