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
}
