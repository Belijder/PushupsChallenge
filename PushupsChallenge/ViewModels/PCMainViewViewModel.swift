//
//  MainViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/04/2023.
//

import UIKit
import SwiftUI

import AVFoundation

final class PCMainViewViewModel: ObservableObject, Countdownable {
    
    @Published var lastWorkout: PCWorkout? = PCWorkout.example
    
    var timer = Timer()
    
    var proximityObserver = ProximityObserver()
    let siriVoice = SiriSpeaking()
   
    
    @Published var mainCounter = 10000

    func startTraining() {
        proximityObserver.delegate = self
        proximityObserver.activateProximitySensor()
        siriVoice.say(sentence: "Get ready!")
    }
    
    func stopTraining() {
        proximityObserver.deactivateProximitySensor()
    }
    
    func countDown() {
        withAnimation {
            mainCounter -= 1
        }
    }
}




protocol Countdownable: AnyObject {
    func countDown()
}



class ProximityObserver  {
    
    weak var delegate: Countdownable?
    
    @objc func didChange(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if device.proximityState == true {
                delegate?.countDown()
            }
        }
    }
    
    func activateProximitySensor() {
        print("MyView::activateProximitySensor")
        UIDevice.current.isProximityMonitoringEnabled = true
        
        if UIDevice.current.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(self.didChange), name: UIDevice.proximityStateDidChangeNotification, object: UIDevice.current)
        }
    }
    
    func deactivateProximitySensor() {
        print("MyView::deactivateProximitySensor")
        UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self, name: UIDevice.proximityStateDidChangeNotification, object: UIDevice.current)
    }
}


class SiriSpeaking {
    var synthesizer = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(language: "en-US")
    let quality = AVSpeechSynthesisVoiceQuality(rawValue: 2)
    
    
    
    func say(sentence: String, delay: Double = 0) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = voice
        utterance.preUtteranceDelay = delay
        synthesizer.speak(utterance)
    }
    
//    func saySentenceToStartWorkout() {
//        synthesizer = AVSpeechSynthesizer()
//        let sentences = ["Get ready!","Five", "Four", "Three", "Two", "One", "Go"]
//
//        //        for number in (0...6) {
//        //            DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(number)) {
//        //                self.say(sentence: sentences[number])
//        //            }
//        //        }
//    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
}
