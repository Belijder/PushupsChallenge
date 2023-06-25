//
//  PCChallengeCompletionPercentageStatisticsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 24/06/2023.
//

import Foundation
import RealmSwift

final class PCChallengeCompletionPercentageStatisticsViewViewModel: ObservableObject {
    
    struct DataForChart: Identifiable {
        let id: UInt64
        let date: Date
        let totalPushups: Int
        
        var shortStringDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
    }
    
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: true)) var workouts
    
    @Published var filteredDataForChart: [DataForChart] = []
    @Published var roundedTotalPercentage = ""
    @Published var days7change = ""
    @Published var days30change = ""
    @Published var totalPercentage: Double = 0
    
    private var days7Averange = 0.0
    private var days30Averange = 0.0
    var dataForChart: [DataForChart] = []
    private var dataForChart7days: [DataForChart] = []
    private var dataForChart30days: [DataForChart] = []
    
    @Published var currentFilterOption = PCTimeScaleString.all {
        didSet {
            switch currentFilterOption {
            case .days7:
                filteredDataForChart = dataForChart7days
            case .days30:
                filteredDataForChart = dataForChart30days
            case .all:
                filteredDataForChart = dataForChart
            }
        }
    }
    
    
    init() {
        totalPercentage = caluclatePercentageOfChallengeCompletion(for: Array(workouts))
        roundedTotalPercentage = String(Int(totalPercentage))+"%"
        calculateChangeFor(timeScale: .days7)
        calculateChangeFor(timeScale: .days30)
        createDataForChart()
        filteredDataForChart = dataForChart
    }
    

    private func caluclatePercentageOfChallengeCompletion(for workouts: [PCWorkout]) -> Double {
        let pushupsArray = workouts.map({ $0.totalReps })
        let totalPushups = pushupsArray.reduce(0, +)
        let percentageOfChallengeCompletion = (Double(totalPushups) / 10000.0) * 100.0
        return percentageOfChallengeCompletion
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
        
        let workouts = self.workouts.filter { $0.date >= startDay }
        let percentageOfChallengeCompletion = caluclatePercentageOfChallengeCompletion(for: Array(workouts))
        
        var stringValue = ""
        
        if percentageOfChallengeCompletion == 0 {
            stringValue = "\(Int(ceil(percentageOfChallengeCompletion)))%"
        } else  {
            stringValue = "+\(Int(ceil(percentageOfChallengeCompletion)))%"
        }
        
        switch timeScale {
        case .days7:
            days7change = stringValue
            days7Averange = percentageOfChallengeCompletion
        case .days30:
            days30change = stringValue
            days30Averange = percentageOfChallengeCompletion
        }
    }
    
    
    private func createDataForChart() {
        var dataForChart: [DataForChart] = []
        
        for (index, workout) in workouts.enumerated() {
            if index == 0 {
                let data = DataForChart(id: workout.id, date: workout.date, totalPushups: workout.totalReps)
                dataForChart.append(data)
            } else {
                let totalPushups = dataForChart[index - 1].totalPushups + workout.totalReps
                let data = DataForChart(id: workout.id, date: workout.date, totalPushups: totalPushups)
                dataForChart.append(data)
            }
        }
        
        let calendar = Calendar.current
        self.dataForChart = dataForChart
        self.dataForChart7days = dataForChart.filter { $0.date >= calendar.date(byAdding: .day, value: -7, to: Date.now) ?? Date.now }
        self.dataForChart30days = dataForChart.filter { $0.date >= calendar.date(byAdding: .day, value: -30, to: Date.now) ?? Date.now }
    }
}
