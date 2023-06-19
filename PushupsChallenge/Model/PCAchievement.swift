//
//  PCAchievement.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 18/06/2023.
//

import Foundation
import RealmSwift

class PCAchievement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var type: PCAchievementType
    @Persisted var isCompleted = false
}
