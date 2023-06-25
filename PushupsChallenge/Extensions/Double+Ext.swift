//
//  Double+Ext.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 24/06/2023.
//

import Foundation

extension Double {
    func withKNotation() -> String {
        if self >= 1000 {
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        } else {
            return String(format: "%.1f", self).replacingOccurrences(of: ".0", with: "")
        }
    }
}
