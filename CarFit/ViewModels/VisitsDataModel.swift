//
//  VisitsDataModel.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

final class VisitsDataModel {
    private let visitData: VisitsData

    init(with _visit: VisitsData) {
        visitData = _visit
    }

    var location: String {
        "\(visitData.houseOwnerAddress) \(visitData.houseOwnerZip) \(visitData.houseOwnerCity)"
    }

    var fullName: String {
        "\(visitData.houseOwnerFirstName) \(visitData.houseOwnerLastName)"
    }

    var visitStatus: VisitState {
        VisitState(rawValue: visitData.visitState) ?? .todo
    }

    var expectedTime: String? {
        visitData.expectedTime
    }

    func requiredTime() -> Int {
        visitData.tasks.reduce(0, { total, task in
            return total + task.timesInMinutes
        })
    }

    func taskDescription() -> String {
        visitData.tasks.map { $0.title }.joined(separator: ", ")
    }
}
