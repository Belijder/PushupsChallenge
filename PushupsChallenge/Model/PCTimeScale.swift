//
//  PCTimeScale.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 25/06/2023.
//

import Foundation

enum PCTimeScale: Int, CaseIterable {
    case days7 = 7
    case days30 = 30
}


enum PCTimeScaleString: String, CaseIterable {
    case all = "All"
    case days30 = "30-days"
    case days7 = "7-days"
}
