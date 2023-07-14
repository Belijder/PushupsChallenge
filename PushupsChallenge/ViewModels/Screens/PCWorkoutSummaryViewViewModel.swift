//
//  PCWorkoutSummaryViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 03/07/2023.
//

import UIKit

final class PCWorkoutSummaryViewViewModel: ObservableObject {
    private let workout: PCWorkout
    
    var capture: UIImage?
    let shareText = "I just finished workout in the push-up challenge. If you want, you can also take part in the challenge. The link to the application can be found here: https://apps.apple.com/app/10k-push-ups/id6450920591"
    
    let duration: String
    let totalReps: String
    let sets: [Int]
    
    init(workout: PCWorkout) {
        self.workout = workout
        duration = workout.workoutDurationString
        totalReps = String(workout.totalReps)
        sets = Array(workout.reps)
    }
}
