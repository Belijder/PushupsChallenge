//
//  PCWorkoutViewOverlayViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import SwiftUI

protocol PCWorkoutOverlayViewViewModelProtocol: AnyObject {
    func didTappedMainButton(overlayType: PCWorkoutOverlayViewType)
    func didTappedFinishWorkoutButton()
    func startWorkout()
    func endBreak()
}

final class PCWorkoutOverlayViewViewModel: ObservableObject {
    let type: PCWorkoutOverlayViewType
    
    private var counter: Int {
        didSet {
            if counter == 0 {
                displayedCounter = "Go!"
            } else {
                displayedCounter = String(counter)
            }
        }
    }
    @Published var displayedCounter = ""
    @Published var displeyTitle: String
    public let mainButtonTitle: String
    
    private var timer: Timer?
    
    weak var delegate: PCWorkoutOverlayViewViewModelProtocol?
    
    init(type: PCWorkoutOverlayViewType, delegate: PCWorkoutOverlayViewViewModelProtocol?) {
        self.type = type
        self.delegate = delegate
        self.counter = type.counterValue + 1
        self.displeyTitle = type.displayTitle
        switch type {
        case .begin:
            self.mainButtonTitle = "Cancel"
        case .break:
            self.mainButtonTitle = "End break"
        }
        
        startTimer()
    }
    

    private func startTimer() {
        switch type {
        case .begin:
            SpeechSynthesizerManager.shared.say(sentence: "Get ready!")
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                if self.counter > 0 {
                    self.counter -= 1
                    SpeechSynthesizerManager.shared.say(sentence: self.displayedCounter)
                } else {
                    timer.invalidate()
                    self.delegate?.startWorkout()
                }
            })
        case .break:
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                if self.counter > 0 {
                    withAnimation {
                        self.counter -= 1
                    }
        
                    if self.counter < 4 {
                        SpeechSynthesizerManager.shared.say(sentence: self.displayedCounter)
                    }
                        
                } else {
                    timer.invalidate()
                    self.delegate?.endBreak()
                }
            })
        }
    }
    
    func mainActionButtonTapped() {
        timer?.invalidate()
        delegate?.didTappedMainButton(overlayType: type)
    }
    
}
