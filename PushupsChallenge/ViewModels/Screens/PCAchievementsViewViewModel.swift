//
//  PCAchievementsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import Foundation
import RealmSwift

final class PCAchievementsViewViewModel: ObservableObject {
    
    @ObservedResults(PCAchievement.self, sortDescriptor: SortDescriptor(keyPath: "id", ascending: true)) var achievements
    
    var achievementsViewModels: [PCAchievementViewViewModel] = []
    
    var achievementsManager = PCAchievementsManager()
    
    init() {
        if achievements.isEmpty {
            PCAchievementType.allCases.forEach { achievementType in
                let newAchievement = PCAchievement()
                newAchievement.type = achievementType
                newAchievement.id = achievementType.rawValue
                $achievements.append(newAchievement)
            }
        }
        
        for achievement in achievements {
            let vm = PCAchievementViewViewModel(achievementType: achievement.type, isCompleted: achievement.isCompleted)
            achievementsViewModels.append(vm)
        }
    }
}
