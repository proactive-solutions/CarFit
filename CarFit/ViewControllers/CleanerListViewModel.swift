//
//  CleanerListViewModal.swift
//  CarFit
//
//  Created by Pawan Sharma on 05/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

final class CleanerListViewModel {
    var visits: [VisitsData] = []

    /// Get visits from the source and parse the response
    func getVisits() -> [VisitsData] {
        guard
            let url = Bundle.main.url(forResource: "carfit", withExtension: "json"),
            let jsonData = try? Data.init(contentsOf: url) else {
                return []
        }
        do {
            let _visits: Visits = try Visits.decodeWith(data: jsonData)
            self.visits = _visits.data
            return self.visits
        } catch {
            self.visits = []
        }
        return []
    }

    /// Returns the visits on a given date
    /// - Parameter date: Date string in `yyyy-MM-dd` format
    /// - Returns: List of visits on the day
    func getVisitsOn(date: String) -> [VisitsData] {
        self.visits.filter {
            $0.startTimeUTC.contains(date)
        }
    }
}
