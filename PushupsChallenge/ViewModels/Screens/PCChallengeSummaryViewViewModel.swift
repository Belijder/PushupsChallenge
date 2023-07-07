//
//  PCChallengeSummaryViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 04/07/2023.
//

import UIKit
import RealmSwift

final class PCChallengeSummaryViewViewModel: ObservableObject {
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: true)) var workouts
    @ObservedResults(PCCompletedChallenge.self) var completedChallenges
    
    var totalPushups: Int = 0
    @Published var totalPushupsString = ""
    var totalWorkouts: Int = 0
    @Published var totalWorkoutsString = ""
    var daysSinceFirstWorkout: Int = 0
    @Published var daysSinceFirstWorkoutString = ""
    var totalWorkoutsDuration: Int = 0
    @Published var totalWorkoutsDurationString = ""
    
    let shareText = "I just finished 10K Push-ups Challenge! 💪 Can you do it faster? Download the app and see for yourself: https://apps.apple.com/app/10k-push-ups/id6450920591"
    var capture: UIImage?
    
    func calculateValues() {
        calculateTotalPushups()
        totalWorkouts = workouts.count
        totalWorkoutsString = String(workouts.count)
        calculateDaysSinceFirstWorkout()
        calculatetotalDurationduration()
    }
    
    
    private func calculateTotalPushups() {
        let pushups = workouts.map { $0.totalReps }
        let total = pushups.reduce(0, +)
        totalPushups = total
        totalPushupsString = String(total)
    }
    
    
    private func calculateDaysSinceFirstWorkout() {
        let calendar = Calendar.current
        
        guard let startDate = workouts.first?.date,
              let endDate = workouts.last?.date
        else {
            daysSinceFirstWorkoutString = "n/a"
            return
        }
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        guard let days = components.day else {
            daysSinceFirstWorkoutString = "n/a"
            return
        }
        daysSinceFirstWorkout = days
        daysSinceFirstWorkoutString = String(days)
    }
    
    
    private func calculatetotalDurationduration() {
        let durations = workouts.map { $0.workoutDuration }
        let totalDuration = durations.reduce(0, +)
        let stringDuration = totalDuration.asStringInClockNotationRoundedToMinutes()
        totalWorkoutsDuration = totalDuration
        totalWorkoutsDurationString = stringDuration
    }
    
    
    func startChallengeAgain() {
        let completedChallenge = PCCompletedChallenge()
        completedChallenge.totalWorkouts = totalWorkouts
        completedChallenge.totalPushups = totalPushups
        completedChallenge.totalWorkoutDuration = totalWorkoutsDuration
        completedChallenge.challengeDurationInDays = daysSinceFirstWorkout
        completedChallenge.startDate = workouts.first?.date
        completedChallenge.endDate = workouts.last?.date
        $completedChallenges.append(completedChallenge)
        
        let realm = try! Realm()
        let workouts = realm.objects(PCWorkout.self)
        
        try! realm.write {
            realm.delete(workouts)
        }
        
        UserDefaults.standard.set(10000, forKey: "mainCounter")
    }
}
