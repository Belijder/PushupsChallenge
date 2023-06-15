//
//  PCAchievementViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import Foundation

final class PCAchievementViewViewModel: ObservableObject {
    let achievement: PCAchievement

    @Published var isSelected = false
    @Published var imageName: String
    
    init(achievement: PCAchievement, isCompleted: Bool) {
        self.achievement = achievement
        self.imageName = isCompleted ? achievement.achievedImageName : achievement.unachievedImageName
    }
    
    func achievementWasTapped() {
        print("Achieviement: \(achievement.rawValue), was tapped()")
    }
    

}
