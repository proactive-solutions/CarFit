//
//  CleanerListViewModal.swift
//  CarFit
//
//  Created by Pawan Sharma on 05/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

final class CleanerListViewModel {
    var visits: Visits?

    /// Get visits from the source and parse the response
    func getVisits() {
        guard
            let url = Bundle.main.url(forResource: "carfit", withExtension: "json"),
            let jsonData = try? Data.init(contentsOf: url) else {
                return
        }
        do {
            self.visits = try Visits.decodeWith(data: jsonData)
        } catch {
            self.visits = nil
        }
    }
}
