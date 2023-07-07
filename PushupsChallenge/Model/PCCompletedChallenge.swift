//
//  PCCompletedChallenge.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 07/07/2023.
//

import Foundation
import RealmSwift

final class PCCompletedChallenge: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var totalPushups: Int
    @Persisted var totalWorkouts: Int
    @Persisted var challengeDurationInDays: Int
    @Persisted var totalWorkoutDuration: Int
    @Persisted var startDate: Date?
    @Persisted var endDate: Date?
}
