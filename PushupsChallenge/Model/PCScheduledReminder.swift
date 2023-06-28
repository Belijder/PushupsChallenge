//
//  PCScheduledReminder.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import Foundation
import RealmSwift

class PCScheduledReminder: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var day: PCWeekday
    @Persisted var hour: Int
    @Persisted var minute: Int
    @Persisted var notificationID: String = UUID().uuidString
    @Persisted var activated: Bool = true
    
    var stringTime: String {
        return String(format: "%02d:%02d", hour, minute)
    }
}


extension PCScheduledReminder {
    static let example = PCScheduledReminder(value: [ "day": PCWeekday.friday,
                                                      "hour": 14,
                                                      "minute": 14,
                                                    ])
}
