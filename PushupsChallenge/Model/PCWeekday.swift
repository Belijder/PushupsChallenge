//
//  PCWeekday.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import Foundation
import RealmSwift

enum PCWeekday: Int, PersistableEnum, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var displayText: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
}
