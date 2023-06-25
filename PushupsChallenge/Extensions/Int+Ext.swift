//
//  Int+Ext.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import Foundation

extension Int {
    func asTimeInMinutesString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        
        if (0...9).contains(seconds) {
            return "\(minutes):0\(seconds)"
        } else {
            return "\(minutes):\(seconds)"
        }
    }
    
    func asStringInClockNotationRoundedToMinutes() -> String {
        var hours = 0
        var minutes = self / 60
        let seconds = self % 60
        
        if minutes > 60 {
            hours = minutes / 60
            minutes = minutes % 60
        }
        
        var string = ""
        
        if hours > 99 {
            return "\(hours)h"
        }
        
        if hours > 0 {
            string.append("\(hours)h ")
        }
        
        if minutes > 0 {
            string.append("\(minutes)m")
        }
        
        if hours == 0, minutes == 0, seconds > 0 {
            string.append("1m")
        }
        
        return string
    }
}
