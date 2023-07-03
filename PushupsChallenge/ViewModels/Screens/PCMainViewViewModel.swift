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






