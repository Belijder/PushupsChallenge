//
//  PCAchievementsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import Foundation

final class PCAchievementsViewViewModel: ObservableObject {
    
    var achievementsViewModels: [PCAchievementViewViewModel] = []
    
    init() {
        for achievement in PCAchievement.allCases {
            let vm = PCAchievementViewViewModel(achievement: achievement, isCompleted: Bool.random())
            achievementsViewModels.append(vm)
        }
    }
    
}
