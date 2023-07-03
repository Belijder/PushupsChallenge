//
//  SpeechSynthesizerManager.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import AVFoundation

class SpeechSynthesizerManager {
    
    static let shared = SpeechSynthesizerManager()
    
    init() { }
    
    var synthesizer = AVSpeechSynthesizer()
    
    func say(sentence: String, delay: Double = 0) {
        let utterance = AVSpeechUtterance(string: sentence)
        let number = UserDefaults.standard.integer(forKey: "voiceNumber")
        
        if let speechLanguage = PCSpeechLanguage(rawValue: number) {
            utterance.voice = AVSpeechSynthesisVoice(identifier: speechLanguage.voiceIdentifier)
        } else {
            utterance.voice = AVSpeechSynthesisVoice(identifier: PCSpeechLanguage.Samantha.voiceIdentifier)
        }
            
        utterance.preUtteranceDelay = delay
        synthesizer.speak(utterance)
    }
}

