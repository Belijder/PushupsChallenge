//
//  PCWorkoutSummaryCellViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 16/06/2023.
//

import Foundation
import SwiftUI
import RealmSwift

final class PCWorkoutSummaryCellViewViewModel: ObservableObject {
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    
    let workout: PCWorkout
    var workoutDate: String
    var duration: String
    @Published var totalReps: Int
    @Published var sets: [Int] = []
    
    
    init(workout: PCWorkout) {
        self.workout = workout
        self.totalReps = workout.totalReps
        self.sets = Array(workout.reps)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        self.workoutDate = formatter.string(from: workout.date)
        
        self.duration = workout.workoutDurationString
    }
    
    
    func deleteWorkout() {
        if let index = workouts.firstIndex(where: { $0.date == self.workout.date }) {
            withAnimation {
                let value =  UserDefaults.standard.integer(forKey: "mainCounter") + workouts[index].totalReps
                UserDefaults.standard.set(value, forKey: "mainCounter")
                $workouts.remove(atOffsets: IndexSet(integer: index))
            }
        }
    }
}
