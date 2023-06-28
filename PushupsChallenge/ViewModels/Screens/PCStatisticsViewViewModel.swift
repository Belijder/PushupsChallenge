//
//  PCStatisticsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 19/06/2023.
//

import Foundation
import RealmSwift

final class PCStatisticsViewViewModel: ObservableObject {
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    
    @Published var mostPushupsInOneWorkoutValue = ""
    @Published var mostPushupsInOneWorkoutDate = ""
    
    @Published var mostPushupsInOneSetValue = ""
    @Published var mostPushupsInOneSetDate = ""
    
    @Published var longestSeriesOfWorkoutsValue = ""
    @Published var longestSeriesOfWorkoutsStartDay = ""
    @Published var longestSeriesOfWorkoutsEndDay = ""
    
    @Published var totalDurationOfWorkouts = ""
    @Published var durationOfWorkoutsThisWeek = ""
    @Published var durationOfWorkoutsThisMonth = ""
    
    @Published var mostActivMonth = ""
    @Published var workoutsInMostActivMonth = ""
    

    init() {
        findWorkoutWithMostPushups()
        findWorkoutWithMostPushupsInOneSet()
        findLongestSeriesOfWorkouts()
        calculateDurationsOfWorkouts()
        findMostActivMonth()
    }
    
    
    private func findWorkoutWithMostPushups() {
        guard let maxPushups = workouts.map({ $0.totalReps }).max(),
              let index = workouts.firstIndex(where: { $0.totalReps == maxPushups })
        else {
            mostPushupsInOneWorkoutDate = "n/a"
            mostPushupsInOneWorkoutValue = "n/a"
            return
        }
        mostPushupsInOneWorkoutValue = String(maxPushups)
        mostPushupsInOneWorkoutDate = workouts[index].date.formatted(date: .long, time: .omitted)
    }
    
    
    private func findWorkoutWithMostPushupsInOneSet() {
        guard let maxSet = workouts.flatMap({ $0.reps }).max(),
              let index = workouts.firstIndex(where: { $0.reps.contains(maxSet) })
        else {
            mostPushupsInOneSetValue = "n/a"
            mostPushupsInOneSetDate  = "n/a"
            return
        }
        mostPushupsInOneSetValue = String(maxSet)
        mostPushupsInOneSetDate = workouts[index].date.formatted(date: .long, time: .omitted)
    }
    
    
    private func findLongestSeriesOfWorkouts() {
        let calendar = Calendar.current
        let sortedDates = createSortadDatesWithoutDuplications()
        
        guard sortedDates.count > 0 else { return }
        
        var longestCounter = 1
        var currentCounter = 1
        var lastDayOfSeries = sortedDates[0]
        
        for (index, date) in sortedDates.enumerated() {
            guard index > 0 else { continue }
            let dayBefor = calendar.date(byAdding: .day, value: -1, to: date)
            
            if dayBefor == sortedDates[index - 1] {
                currentCounter += 1
            } else {
                if longestCounter < currentCounter {
                    longestCounter = currentCounter
                    lastDayOfSeries = sortedDates[index - 1]
                }
                
                currentCounter = 1
            }
        }
        
        longestSeriesOfWorkoutsValue = String(longestCounter)
        
        if let startDay = calendar.date(byAdding: .day, value: -(longestCounter-1), to: lastDayOfSeries) {
            longestSeriesOfWorkoutsStartDay = startDay.formatted(date: .long, time: .omitted)
        }
        
        longestSeriesOfWorkoutsEndDay = lastDayOfSeries.formatted(date: .long, time: .omitted)
    }
    
    
    private func createSortadDatesWithoutDuplications() -> [Date] {
        let calendar = Calendar.current
        let datesComponents = workouts.map { calendar.dateComponents([.year, .month, .day], from: $0.date) }
        let setOfdatesComponents = Set(datesComponents)
        let arrayOfDateComponents = Array(setOfdatesComponents)
        let sortedDates = arrayOfDateComponents.compactMap { calendar.date(from: $0) }.sorted()
        return sortedDates
    }

    
    private func calculateDurationsOfWorkouts() {
        let calendar = Calendar.current
        let totalDuration = workouts.map({ $0.workoutDuration }).reduce(0, +)
        totalDurationOfWorkouts = totalDuration.asStringInClockNotationRoundedToMinutes()

        
        guard let thisWeekDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date.now)),
              let thisMonthDate = calendar.date(from: calendar.dateComponents([.month, .year], from: Date.now))
        else {
            durationOfWorkoutsThisWeek = "n/a"
            durationOfWorkoutsThisMonth = "n/a"
            return
        }
        
        let thisMonthWorkout = workouts.filter({ $0.date > thisMonthDate })
        let thisMonthDuration = thisMonthWorkout
                                    .map({ $0.workoutDuration })
                                    .reduce(0, +)
        
        let thisWeekDuration = thisMonthWorkout
                                    .filter({ $0.date > thisWeekDate })
                                    .map({ $0.workoutDuration })
                                    .reduce(0, +)
        
        durationOfWorkoutsThisWeek = thisWeekDuration.asStringInClockNotationRoundedToMinutes()
        durationOfWorkoutsThisMonth = thisMonthDuration.asStringInClockNotationRoundedToMinutes()
    }
    
    
    private func findMostActivMonth() {
        let calendar = Calendar.current
        let sortedDates = createSortadDatesWithoutDuplications()
        let dateComponents = sortedDates.map({ calendar.dateComponents([.month, .year], from: $0) })
        
        guard dateComponents.count > 0 else { return }
        
        let countedSet = NSCountedSet(array: dateComponents)
        var maxCount = 0
        var mostFrequentElement = dateComponents[0]
        
        for item in dateComponents {
            let count = countedSet.count(for: item)
            if count > maxCount {
                maxCount = count
                mostFrequentElement = item
            }
        }
        
        workoutsInMostActivMonth = String(maxCount)
        
        guard let date = calendar.date(from: mostFrequentElement)?.formatted(
            Date.FormatStyle()
                .month(.wide)
                .year()
        ) else {
            mostActivMonth = "n/a"
            return
        }
        
        mostActivMonth = date 
    }
}
