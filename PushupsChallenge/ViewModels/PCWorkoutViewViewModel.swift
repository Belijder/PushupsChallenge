//
//  PCWorkoutViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import SwiftUI
import AVFoundation

protocol PCWorkoutViewViewModelProtocol: AnyObject {
    func substractFromMainCounter()
    func hideWorkoutSheet()
}

final class PCWorkoutViewViewModel: ObservableObject, Countable {
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
    
    func stopTraining() {
        timer?.invalidate()
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
            print("Sound file not found")
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
        //Save workout data
        
        delegate?.hideWorkoutSheet()
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
            delegate?.hideWorkoutSheet()
        case .break:
            overlayView = nil
            startNewSet()
        }
    }
    
    
    
    
    func didTappedFinishWorkoutButton() {
        endWorkout()
    }
}
