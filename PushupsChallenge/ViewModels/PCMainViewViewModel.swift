//
//  MainViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/04/2023.
//

import UIKit
import SwiftUI
import AVFoundation



final class PCMainViewViewModel: ObservableObject {
    
    @Published var lastWorkout: PCWorkout? = PCWorkout.example
    @Published var mainCounter = 10000
    @Published var newWorkoutSheetIsPresented = false
    



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






