//
//  PCWorkoutViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import SwiftUI
import AVFoundation
import RealmSwift

protocol PCWorkoutViewViewModelProtocol: AnyObject {
    func substractFromMainCounter()
    func hideWorkoutSheet(workout: PCWorkout?)
}

final class PCWorkoutViewViewModel: ObservableObject, Countable {
    @ObservedResults(PCWorkout.self) var workouts
    
    init(delegate: PCWorkoutViewViewModelProtocol?) {
        self.delegate = delegate
        overlayView = PCWorkoutOverlayView(type: .begin, delegate: self)
    }

    // MARK: - Properties
    private let proximityObserver = ProximityObserverManager()
    private var timer: Timer?
    weak var delegate: PCWorkoutViewViewModelProtocol?
    
    private var workoutDuration = 0 {
        didSet {
            displayedWorkoutTime = workoutDuration.asTimeInMinutesString()
        }
    }
    
    private var doneAudioPlayer: AVAudioPlayer?
    
    @Published var displayedWorkoutTime = "0:00"
    @Published var currentSet = 1
    @Published var currentReps = 0 {
        didSet {
            totalReps = previousSets.reduce(0, +) + currentReps
        }
    }
    
    var previousSets: [Int] = [] {
        didSet {
            let setsStrings = previousSets.map { String($0) }
            displayedPreviousSets = setsStrings.joined(separator: " / ")
        }
    }
    
    @Published var displayedPreviousSets = ""
    @Published var totalReps = 0
    @Published var overlayView: PCWorkoutOverlayView?
    
    func startBreak() {
        overlayView = PCWorkoutOverlayView(type: .break, delegate: self)
        proximityObserver.deactivateProximitySensor()
    }
    
  
    func changeCountNumber() {
        withAnimation {
            currentReps += 1
        }
        playDoneSound()
        delegate?.substractFromMainCounter()
    }
    
    
    private func playDoneSound() {
        guard let soundURL = Bundle.main.url(forResource: "Done", withExtension: "MP3") else {
            return
        }
        
        doneAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        doneAudioPlayer?.play()
    }
    
    
    private func startNewSet() {
        proximityObserver.activateProximitySensor()
        currentSet += 1
        previousSets.append(currentReps)
        currentReps = 0
    }
    
    
    func endWorkout() {
        proximityObserver.deactivateProximitySensor()
        let newWorkout = PCWorkout()
        newWorkout.date = Date()
        newWorkout.totalReps = totalReps
        newWorkout.reps.append(objectsIn: previousSets)
        newWorkout.reps.append(currentReps)
        newWorkout.workoutDuration = workoutDuration
        $workouts.append(newWorkout)

        
//        RANDOM WORKOUTS
//        let calendar = Calendar.current
//        for number in 1...43 {
//            let newWorkout = PCWorkout()
//            newWorkout.date = calendar.date(byAdding: .day, value: -number, to: Date.now)!
//            let randomArrayReps = [Int.random(in: 10...20), Int.random(in: 10...20), Int.random(in: 10...20), Int.random(in: 10...20)]
//            let totalRandom = randomArrayReps.reduce(0, +)
//
//            newWorkout.reps.append(objectsIn: randomArrayReps)
//            newWorkout.totalReps = totalRandom
//            newWorkout.workoutDuration = (totalReps * 2) + 90
//            $workouts.append(newWorkout)
//
//        }
        
        
        PCAchievementsManager.shared.checkAchievementsCompletion()
        delegate?.hideWorkoutSheet(workout: newWorkout)
    }
}

extension PCWorkoutViewViewModel: PCWorkoutOverlayViewViewModelProtocol {
    func endBreak() {
        overlayView = nil
        startNewSet()
    }
    
    
    func startWorkout() {
        overlayView = nil
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.workoutDuration += 1
        })
        
        proximityObserver.delegate = self
        proximityObserver.activateProximitySensor()
    }
    
    
    func didTappedMainButton(overlayType: PCWorkoutOverlayViewType) {
        switch overlayType {
        case .begin:
            delegate?.hideWorkoutSheet(workout: nil)
        case .break:
            overlayView = nil
            startNewSet()
        }
    }
    
    
    func didTappedFinishWorkoutButton() {
        endWorkout()
    }
}
