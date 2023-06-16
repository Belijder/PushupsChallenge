//
//  PCAchievementViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import Foundation

final class PCAchievementViewViewModel: ObservableObject {
    let achievement: PCAchievement

//    @Published var isSelected = false
    @Published var imageName: String
    @Published var badgeID: String
    @Published var titleMessage: String
    @Published var additionalText: String
    
    init(achievement: PCAchievement, isCompleted: Bool) {
        self.achievement = achievement
        self.imageName = isCompleted ? achievement.achievedImageName : achievement.unachievedImageName
        self.badgeID = "badge\(achievement.rawValue)"
        self.titleMessage = achievement.title
        self.additionalText = isCompleted ? achievement.completedAdditionalText : achievement.uncompletedAdditionalText
    }
    
//    func achievementWasTapped() {
//        print("Achieviement: \(achievement.rawValue), was tapped()")
//    }
    

}
