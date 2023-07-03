//
//  PCSpeechLanguage.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 30/06/2023.
//

import Foundation

enum PCSpeechLanguage: Int, CaseIterable {
    case Samantha
    case Aaron
    case Daniel
    case Martha
    case Majed
    case Helena
    case Martin
    case Kyoko
    case Mónica
    case Alice
    case Thomas
    case Marie
    case Zosia
    case Tingting
 
    var voiceIdentifier: String {
        switch self {
        case .Samantha:
            return "com.apple.voice.compact.en-US.Samantha"
        case .Aaron:
            return "com.apple.ttsbundle.siri_Aaron_en-US_compact"
        case .Daniel:
            return "com.apple.voice.compact.en-GB.Daniel"
        case .Martha:
            return "com.apple.ttsbundle.siri_Martha_en-GB_compact"
        case .Majed:
            return "com.apple.voice.compact.ar-001.Maged"
        case .Helena:
            return "com.apple.ttsbundle.siri_Helena_de-DE_compact"
        case .Martin:
            return "com.apple.ttsbundle.siri_Martin_de-DE_compact"
        case .Kyoko:
            return "com.apple.voice.compact.ja-JP.Kyoko"
        case .Mónica:
            return "com.apple.voice.compact.es-ES.Monica"
        case .Alice:
            return "com.apple.voice.compact.it-IT.Alice"
        case .Thomas:
            return "com.apple.voice.compact.fr-FR.Thomas"
        case .Marie:
            return "com.apple.ttsbundle.siri_Marie_fr-FR_compact"
        case .Zosia:
            return "com.apple.voice.compact.pl-PL.Zosia"
        case .Tingting:
            return "com.apple.voice.compact.zh-CN.Tingting"
        }
    }
    
    var getReadyText: String {
        switch self {
        case .Samantha, .Aaron, .Daniel, .Martha:
            return "Get Ready!"
        case .Majed:
            return "iistaeid!"
        case .Helena, .Martin:
            return "Bereit machen!"
        case .Kyoko:
            return "Junbi o shimashou!"
        case .Mónica:
            return "¡Prepararse!"
        case .Alice:
            return "Preparati!"
        case .Thomas, .Marie:
            return "Sois prêt!"
        case .Zosia:
            return "Przygotuj się!"
        case .Tingting:
            return "Zuò hǎo zhǔnbèi!"
        }
    }
    
    
    var goText: String {
        switch self {
        case .Samantha, .Aaron, .Daniel, .Martha:
            return "Go!"
        case .Majed:
            return "Linabda!"
        case .Helena, .Martin:
            return "Start"
        case .Kyoko:
            return "Hajimemashou!"
        case .Mónica:
            return "¡Empecemos!"
        case .Alice:
            return "Inizio!"
        case .Thomas, .Marie:
            return "Commençons!"
        case .Zosia:
            return "Ruszaj!"
        case .Tingting:
            return "Kāishǐ ba!"
        }
    }
    
    
    var titleLabel: String {
        switch self {
        case .Samantha:
            return "Samantha (English-US)"
        case .Aaron:
            return "Aaron (English-US)"
        case .Daniel:
            return "Daniel (English-GB)"
        case .Martha:
            return "Martha (English-GB)"
        case .Majed:
            return "Majed (Arabic)"
        case .Helena:
            return "Helenda (German)"
        case .Martin:
            return "Martin (German)"
        case .Kyoko:
            return "Kyoko (Japanese)"
        case .Mónica:
            return "Mónica (Spanish)"
        case .Alice:
            return "Alice (Italian)"
        case .Thomas:
            return "Thomas (French)"
        case .Marie:
            return "Marie (French)"
        case .Zosia:
            return "Zosia (Polish)"
        case .Tingting:
            return "Tingting (Chinese)"
        }
    }
}
