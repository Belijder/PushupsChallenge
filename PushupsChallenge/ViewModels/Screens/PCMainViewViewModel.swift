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
    @AppStorage("mainCounter") var mainCounter = 10000
    
    @Published var newWorkoutSheetIsPresented = false
    @Published var achievementsSheetIsPresented = false
    @Published var workoutsSummaryListISPresented = false
    @Published var showSummary = false
    
    var lastWorkout: PCWorkout? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showSummary = true
            }
        }
    }
}


extension PCMainViewViewModel: PCWorkoutViewViewModelProtocol {
    func substractFromMainCounter() {
        withAnimation {
            if mainCounter > 0 {
                mainCounter -= 1
            }
        }
    }
    
    func hideWorkoutSheet(workout: PCWorkout?) {
        newWorkoutSheetIsPresented = false
        
        guard let workout = workout else {
            return
        }
        
        lastWorkout = workout

    }
}






