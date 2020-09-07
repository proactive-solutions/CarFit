//
//  File.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

// MARK: - Datum
struct VisitsData: Codable {
    let visitID: String
    let homeBobEmployeeID: String
    let houseOwnerID: String
    let isBlocked: Bool
    let startTimeUTC: String
    let endTimeUTC: String
    let title: String
    let isReviewed: Bool
    let isFirstVisit: Bool
    let isManual: Bool
    let visitTimeUsed: Int
    let rememberToday: JSONNull?
    let houseOwnerFirstName: String
    let houseOwnerLastName: String
    let houseOwnerMobilePhone: String
    let houseOwnerAddress: String
    let houseOwnerZip: String
    let houseOwnerCity: String
    let houseOwnerLatitude: Double
    let houseOwnerLongitude: Double
    let isSubscriber: Bool
    let rememberAlways: JSONNull?
    let professional: String
    let visitState: String
    let stateOrder: Int
    let expectedTime: String?
    let tasks: [Task]
    let houseOwnerAssets: [JSONAny]
    let visitAssets: [JSONAny]
    let visitMessages: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case visitID = "visitId"
        case homeBobEmployeeID = "homeBobEmployeeId"
        case houseOwnerID = "houseOwnerId"
        case isBlocked
        case startTimeUTC = "startTimeUtc"
        case endTimeUTC = "endTimeUtc"
        case title
        case isReviewed
        case isFirstVisit
        case isManual
        case visitTimeUsed
        case rememberToday
        case houseOwnerFirstName
        case houseOwnerLastName
        case houseOwnerMobilePhone
        case houseOwnerAddress
        case houseOwnerZip
        case houseOwnerCity
        case houseOwnerLatitude
        case houseOwnerLongitude
        case isSubscriber
        case rememberAlways
        case professional
        case visitState
        case stateOrder
        case expectedTime
        case tasks
        case houseOwnerAssets
        case visitAssets
        case visitMessages
    }
}
