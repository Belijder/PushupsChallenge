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
    let voice = AVSpeechSynthesisVoice(language: "en-US")
    let quality = AVSpeechSynthesisVoiceQuality(rawValue: 2)
    
    func say(sentence: String, delay: Double = 0) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = voice
        utterance.preUtteranceDelay = delay
        synthesizer.speak(utterance)
    }
}
