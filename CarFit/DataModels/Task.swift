//
//  Task.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

// MARK: - Task
struct Task: Codable {
    let taskID: String
    let title: String
    let isTemplate: Bool
    let timesInMinutes: Int
    let price: Int
    let paymentTypeID: String
    let createDateUTC: String
    let lastUpdateDateUTC: String
    let paymentTypes: JSONNull?

    enum CodingKeys: String, CodingKey {
        case taskID = "taskId"
        case title
        case isTemplate
        case timesInMinutes
        case price
        case paymentTypeID = "paymentTypeId"
        case createDateUTC = "createDateUtc"
        case lastUpdateDateUTC = "lastUpdateDateUtc"
        case paymentTypes
    }
}
