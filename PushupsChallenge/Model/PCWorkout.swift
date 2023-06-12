//
//  PCWorkout.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 08/06/2023.
//

import Foundation

struct PCWorkout {
    let date: Date
    let workoutDuration: Int
    let reps: [Int]
    let totalReps: Int
    
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
        let minutes = workoutDuration / 60
        let seconds = workoutDuration % 60
        
        return "\(minutes):\(seconds)"
    }
    
    static let example = PCWorkout(date: Date.now - 150000,
                                   workoutDuration: 130,
                                   reps: [19, 20, 21, 16],
                                   totalReps: 76)
}
