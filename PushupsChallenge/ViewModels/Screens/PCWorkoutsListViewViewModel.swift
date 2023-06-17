//
//  PCWorkoutsListViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 16/06/2023.
//

import Foundation
import RealmSwift
import SwiftUI

final class PCWorkoutsListViewViewModel: ObservableObject {
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    
    @Published var filteredWorkout: [PCWorkout] = []
    @Published var textForEmptyState = ""

    
    init() {
        filteredWorkout = Array(workouts)
    }
    
    @Published var selectedFilterOption: PCWorkoutFilterOption = .all {
        didSet {
            switch selectedFilterOption {
            case .week:
                filterThisWeekWorkouts()
            case .month:
                filterThisMonthWorkouts()
            case .all:
                filteredWorkout = Array(workouts)
            }
            
            textForEmptyState = workouts.isEmpty ? PCWorkoutFilterOption.all.textForEmptyFilterResult : selectedFilterOption.textForEmptyFilterResult
        }
    }
    
    private func filterThisWeekWorkouts() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))
        
        let filteredWorkouts = workouts.filter { workout in
            guard let workoutDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: workout.date)) else {
                return false
            }
            
            return workoutDate >= startOfWeek!
        }
        self.filteredWorkout = Array(filteredWorkouts)
    }
    
    func thisWeekStartDate() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) ?? Date()
    }
    
    private func filterThisMonthWorkouts() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let startDateComponents = DateComponents(year: currentYear, month: currentMonth)
        
        let startOfMonth = calendar.date(from: startDateComponents)
        
        let filteredWorkouts = workouts.filter { workout in
            guard let workoutDate = calendar.date(from: calendar.dateComponents([.year, .month], from: workout.date)) else {
                return false
            }
            
            return workoutDate >= startOfMonth!
        }
        self.filteredWorkout = Array(filteredWorkouts)
    }
    
    func thisMonthStartDate() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let startDateComponents = DateComponents(year: currentYear, month: currentMonth)
        
        return calendar.date(from: startDateComponents) ?? Date()
    }
}
