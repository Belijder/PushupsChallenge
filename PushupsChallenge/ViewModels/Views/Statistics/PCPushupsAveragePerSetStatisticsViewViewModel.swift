//
//  PCPushupsAveragePerSetStatisticsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 22/06/2023.
//

import Foundation
import RealmSwift

final class PCPushupsAveragePerSetStatisticsViewViewModel: ObservableObject {
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    
    @Published var filteredWorkouts: [PCWorkout] = []
    @Published var roundedAverage = ""
    @Published var days7change = ""
    @Published var days30change = ""
    @Published var pushUpsAverange: Double = 0
    
    private var days7Averange = 0.0
    private var days30Averange = 0.0
    private var filteredWorkouts7days: [PCWorkout] = []
    private var filteredWorkouts30days: [PCWorkout] = []
    
    @Published var currentFilterOption = PCTimeScaleString.all {
        didSet {
            switch currentFilterOption {
            case .days7:
                filteredWorkouts = filteredWorkouts7days
            case .days30:
                filteredWorkouts = filteredWorkouts30days
            case .all:
                filteredWorkouts = Array(workouts)
            }
        }
    }
    
    
    init() {
        pushUpsAverange = caluclateAverangeOfPushupsInSet(for: Array(workouts))
        roundedAverage = String(Int(pushUpsAverange))
        calculateChangeFor(timeScale: .days7)
        calculateChangeFor(timeScale: .days30)
        filteredWorkouts = Array(workouts)
    }
    
    
    private func caluclateAverangeOfPushupsInSet(for workouts: [PCWorkout]) -> Double {
        let pushupsArrayBySets = workouts.flatMap { $0.reps }
        let totalPushups = pushupsArrayBySets.reduce(0, +)
        let totalSets = pushupsArrayBySets.count
        return Double(totalPushups) / Double(totalSets)
    }
    
    
    private func calculateChangeFor(timeScale: PCTimeScale) {
        let calendar = Calendar.current
        guard let startDay = calendar.date(byAdding: .day, value: -timeScale.rawValue, to: Date.now) else {
            switch timeScale {
            case .days7:
                days7change = "n/a"
            case .days30:
                days30change = "n/a"
            }
            return
        }
        
        let workouts = Array(self.workouts.filter { $0.date >= startDay })
        let averageForFilteredWorkOuts = caluclateAverangeOfPushupsInSet(for: workouts)
        let change = ((averageForFilteredWorkOuts / self.pushUpsAverange) * 100.0) - 100.0
        
        var stringValue = ""
        
        if change <= 0 {
            stringValue = "\(Int(ceil(change)))%"
        } else  {
            stringValue = "+\(Int(ceil(change)))%"
        }
        
        switch timeScale {
        case .days7:
            days7change = stringValue
            days7Averange = averageForFilteredWorkOuts
            filteredWorkouts7days = workouts
        case .days30:
            days30change = stringValue
            days30Averange = averageForFilteredWorkOuts
            filteredWorkouts30days = workouts
        }
    }
}
