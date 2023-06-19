//
//  PCAchievementViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import Foundation

final class PCAchievementViewViewModel: ObservableObject {
    let achievementType: PCAchievementType

    @Published var imageName: String
    @Published var badgeID: String
    @Published var titleMessage: String
    @Published var additionalText: String
    
    init(achievementType: PCAchievementType, isCompleted: Bool) {
        self.achievementType = achievementType
        self.imageName = isCompleted ? achievementType.achievedImageName : achievementType.unachievedImageName
        self.badgeID = "badge\(achievementType.rawValue)"
        self.titleMessage = achievementType.title
        self.additionalText = isCompleted ? achievementType.completedAdditionalText : achievementType.uncompletedAdditionalText
    }
}
