//
//  PCAchievementsManager.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 18/06/2023.
//

import Foundation
import RealmSwift

final class PCAchievementsManager: ObservableObject {
    
    static let shared = PCAchievementsManager()
    
    init() { }
    
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    @ObservedResults(PCAchievement.self) var achievements
    
    
    func checkAchievementsCompletion() {
        try? Realm().write({
            achievements.forEach { $0.isCompleted = false }
        })
        checkExerciseFrequencyInMonth()
        checkTotalPushupsDone()
        checkHeighestNumberOfRepsInWorkout()
        checkHeighestNumberOfRepsInSet()
        checkTotalDurationOfWorkOut()

        let sortedDates = createSortadDatesWithoutDuplications()
        ckeckWorkoutsConsecutive(for: 10, sortedDates: sortedDates)
    }
    
   
    private func checkExerciseFrequencyInMonth() {
        var counter = 1 {
            didSet {
                if counter == 5 {
                    markAsCompleted(.workoutsInMonth5)
                }
                
                if counter == 15 {
                    markAsCompleted(.workoutsInMonth15)
                }
            }
        }
        
        let calendar = Calendar.current
        let datesComponents = workouts.map{ calendar.dateComponents([.year, .month], from: $0.date) }
        
        for (index, dateComponents) in datesComponents.enumerated() {
            if counter >= 25 {
                markAsCompleted(.workoutsInMonth25)
                return
            } else {
                if index > 0 {
                    if dateComponents == datesComponents[index - 1] {
                        counter += 1
                    } else {
                        counter = 1
                    }
                }
            }
        }
    }
    
    
    private func checkTotalPushupsDone() {
        let repsInWorkout = workouts.map({ $0.totalReps })
        let totalReps = repsInWorkout.reduce(0, +)
        
        if totalReps >= 1000 {
            markAsCompleted(.pushups1000)
        }
        
        if totalReps >= 5000 {
            markAsCompleted(.pushups5000)
        }
        
        if totalReps >= 10000 {
            markAsCompleted(.pushups10000)
        }
    }
    
    
    private func checkHeighestNumberOfRepsInWorkout() {
        let repsInWorkout = workouts.map({ $0.totalReps })
        
        guard let highestNumber = repsInWorkout.max() else {
            return
        }
        
        if highestNumber >= 20 {
            markAsCompleted(.oneTimePushups20)
            
            if highestNumber >= 50 {
                markAsCompleted(.oneTimePushups50)
                
                if highestNumber >= 100 {
                    markAsCompleted(.oneTimePushups100)
                }
            }
        }
    }
    
    
    private func checkHeighestNumberOfRepsInSet() {
        let repsInSets = workouts.flatMap { $0.reps }
        guard let highestNumber = repsInSets.max() else {
            return
        }

        if highestNumber >= 20 {
            markAsCompleted(.pushupsInOnset20)
            
            if highestNumber >= 30 {
                markAsCompleted(.pushupsInOnset30)
                
                if highestNumber >= 50 {
                    markAsCompleted(.pushupsInOnset50)
                }
            }
        }
    }
    
    
    private func checkTotalDurationOfWorkOut() {
        let durations = workouts.map { $0.workoutDuration }
        let totalDuration = durations.reduce(0, +)
        
        if totalDuration >= 3600 {
            markAsCompleted(.totalduration1h)

            if totalDuration >= 18000 {
                markAsCompleted(.totalduration5h)
   
                if totalDuration >= 36000 {
                    markAsCompleted(.totalduration10h)
                }
            }
        }
    }
    
    
    private func ckeckWorkoutsConsecutive(for number: Int, sortedDates: [Date]) {
        let calendar = Calendar.current
        let sortedDates = sortedDates

        guard sortedDates.count >= number else {
            return
        }
        
        for i in 0...(sortedDates.count - number) {
            let startDate = sortedDates[i]
           
            let expectedEndDate = calendar.date(byAdding: .day, value: number - 1, to: startDate)
           
            if sortedDates[i + number - 1] == expectedEndDate {
                switch number {
                case 10:
                    markAsCompleted(.workoutsInRow10)
                    ckeckWorkoutsConsecutive(for: 20, sortedDates: sortedDates)
                    return
                case 20:
                    markAsCompleted(.workoutsInRow20)
                    ckeckWorkoutsConsecutive(for: 50, sortedDates: sortedDates)
                    return
                case 50:
                    markAsCompleted(.workoutsInRow50)
                    return
                default:
                    return
                }
            } else {
                continue
            }
        }
    }
    
    
    private func createSortadDatesWithoutDuplications() -> [Date] {
        let calendar = Calendar.current
        let datesComponents = workouts.map { calendar.dateComponents([.year, .month, .day], from: $0.date) }
        let setOfdatesComponents = Set(datesComponents)
        let arrayOfDateComponents = Array(setOfdatesComponents)
        let sortedDates = arrayOfDateComponents.compactMap { calendar.date(from: $0) }.sorted()
        return sortedDates
    }
    
    
    private func markAsCompleted(_ achievementType: PCAchievementType) {
        if let index = achievements.firstIndex(where: { $0.type == achievementType }) {
            if achievements[index].isCompleted == false {
                try? Realm().write({
                    achievements[index].isCompleted = true
                })  
            }
        }
    }
}
