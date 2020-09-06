//
//  CarWashStatus.swift
//  CarFit
//
//  Created by Pawan Sharma on 06/09/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation
import UIKit

enum VisitState: String {
    case todo = "ToDo"
    case inProgress = "InProgress"
    case done = "Done"
    case rejected = "Rejected"
}

extension VisitState {
    func color() -> UIColor {
        switch self {
        case .todo:
            return .todoOption

        case .inProgress:
            return .inProgressOption

        case .rejected:
            return .rejectedOption

        case .done:
            return .doneOption
        }
    }
}
