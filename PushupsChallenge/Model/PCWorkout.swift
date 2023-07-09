//
//  PCWorkout.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 08/06/2023.
//

import Foundation
import RealmSwift

final class PCWorkout: Object, ObjectKeyIdentifiable {
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
            if days == 1 {
                return " - yesterday"
            } else {
                return days == 0 ? "" : " - \(days) days ago"
            }
        } else {
            return " - Never"
        }
    }
    
    var workoutDurationString: String {
        workoutDuration.asTimeInMinutesString()
    }
    
    var shortStringDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}


extension PCWorkout {
    static let example = PCWorkout(value: ["date": Date.now,
                                           "workoutDuration": 129,
                                           "reps": [19, 20, 21, 16],
                                           "totalReps": 76
                                          ])

    
    static var arrayOfExamples: [PCWorkout] {
        var examples: [PCWorkout] = []
        let calendar = Calendar.current
        
        for number in 1...43 {
            let newWorkout = PCWorkout()
            newWorkout.date = calendar.date(byAdding: .day, value: -number, to: Date.now)!
            let randomArrayReps = [Int.random(in: 10...20), Int.random(in: 10...20), Int.random(in: 10...20), Int.random(in: 10...20)]
            let totalRandom = randomArrayReps.reduce(0, +)
            
            newWorkout.reps.append(objectsIn: randomArrayReps)
            newWorkout.totalReps = totalRandom
            newWorkout.workoutDuration = (totalRandom * 2) + 90
            examples.append(newWorkout)
        }
        
        return examples
    }
}
