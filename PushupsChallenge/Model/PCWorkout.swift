//
//  PCWorkout.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 08/06/2023.
//

import Foundation
import RealmSwift

class PCWorkout: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var workoutDuration: Int
    @Persisted var reps: List<Int>
    @Persisted var totalReps: Int
    
    var daysSinceLastTraining: String {
        let currentDate = Date.now
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        
        if let days = components.day {
            return days == 0 ? "" : " - \(days) days ago"
        } else {
            return " - Never"
        }
    }
    
    var workoutDurationString: String {
        workoutDuration.asTimeInMinutesString()
    }
    
//    static let example = PCWorkout(date: Date.now - 150000,
//                                   workoutDuration: 129,
//                                   reps: [19, 20, 21, 16],
//                                   totalReps: 76)
}
