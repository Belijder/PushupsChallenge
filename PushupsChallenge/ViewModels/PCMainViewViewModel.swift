//
//  MainViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/04/2023.
//

import UIKit
import SwiftUI
import AVFoundation
import RealmSwift



final class PCMainViewViewModel: ObservableObject {
    
    @ObservedResults(PCWorkout.self, sortDescriptor: "date") var workouts

    
//    @Published var lastWorkout: PCWorkout?
    @Published var mainCounter = 10000
    @Published var newWorkoutSheetIsPresented = false
    
    func calculateTotalRepsPerformed() -> Int  {
        let reps = workouts.compactMap { $0.totalReps }
        return reps.reduce(0, +)
    }
    
    init() {
        let totalRepsPerformed = calculateTotalRepsPerformed()
        mainCounter = 10000 - totalRepsPerformed
    }
        

}

extension PCMainViewViewModel: PCWorkoutViewViewModelProtocol {
    func substractFromMainCounter() {
        withAnimation {
            mainCounter -= 1
        }
    }
    
    func hideWorkoutSheet() {
        newWorkoutSheetIsPresented = false
    }
}






