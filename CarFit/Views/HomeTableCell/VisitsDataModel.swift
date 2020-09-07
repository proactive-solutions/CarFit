//
//  VisitsDataModel.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation
import CoreLocation

/// Class to manipulate Visits data
final class VisitsDataModel {
    private let visitData: VisitsData

    init(with _visit: VisitsData) {
        visitData = _visit
    }

    var location: String {
        "\(visitData.houseOwnerAddress) \(visitData.houseOwnerZip) \(visitData.houseOwnerCity)"
    }

    /// Full name of the owner
    var fullName: String {
        "\(visitData.houseOwnerFirstName) \(visitData.houseOwnerLastName)"
    }

    var visitStatus: VisitState {
        VisitState(rawValue: visitData.visitState) ?? .todo
    }

    var expectedTime: String? {
        visitData.expectedTime
    }

    /// Time required to complete all the tasks needs to be done. It sums up the time required to perform individual tasks in the visit
    /// - Returns: Total time needed to finish all the tasks
    func requiredTime() -> Int {
        visitData.tasks.reduce(0, { total, task in
            return total + task.timesInMinutes
        })
    }

    /// Displays title of all tasks separated by a comma i.e. ","
    /// - Returns: Comma separated tasks names
    func taskDescription() -> String {
        visitData.tasks.map { $0.title }.joined(separator: ", ")
    }

    /// Calcuates distance between last visit location and current
    /// visit location. Measured in KMs
    /// - Parameter previousLocation: previous visit location
    /// - Returns: Distance between last and current visit in KMs
    func distanceFrom(previousLocation: CLLocation) -> Double {
        let currentVisitLocation = CLLocation(
            latitude: visitData.houseOwnerLatitude,
            longitude: visitData.houseOwnerLongitude
        )
        return (currentVisitLocation.distance(from: previousLocation) / 1000.0)
    }
}
