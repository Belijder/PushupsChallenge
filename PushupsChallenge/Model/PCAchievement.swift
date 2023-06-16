//
//  PCAchievement.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 15/06/2023.
//

import Foundation

enum PCAchievement: Int, CaseIterable {
    case pushups1000
    case pushups5000
    case pushups10000
    
    case workoutsInMonth5
    case workoutsInRow15
    case workoutsInRow25
    
    case oneTimePushups20
    case oneTimePushups50
    case oneTimePushups100
    
    case workoutsInRow10
    case workoutsInRow20
    case workoutsInRow50
    
    case totalduration1h
    case totalduration5h
    case totalduration10h
    
    case pushupsInOnset20
    case pushupsInOnset30
    case pushupsInOnset50
    
    
    var unachievedImageName: String {
        return "achievement\(rawValue + 1)g"
    }
    
    var achievedImageName: String {
        return "achievement\(rawValue + 1)c"
    }
    
    var title: String {
        switch self {
        case .pushups1000:
            return "1000 push-ups in total"
        case .pushups5000:
            return "5000 push-ups in total"
        case .pushups10000:
            return "10000 Push-ups in total"
        case .workoutsInMonth5:
            return "5 workout in one month"
        case .workoutsInRow15:
            return "15 workout in one month"
        case .workoutsInRow25:
            return "25 workout in one month"
        case .oneTimePushups20:
            return "20 push-ups in one workout"
        case .oneTimePushups50:
            return "50 push-ups in one workout"
        case .oneTimePushups100:
            return "100 push-ups in one workout"
        case .workoutsInRow10:
            return "10 days in a row with training"
        case .workoutsInRow20:
            return "20 days in a row with training"
        case .workoutsInRow50:
            return "50 days in a row with training"
        case .totalduration1h:
            return "1 hour of training in total"
        case .totalduration5h:
            return "5 hours of training in total"
        case .totalduration10h:
            return "10 hour of training in total"
        case .pushupsInOnset20:
            return "20 push-ups in one set"
        case .pushupsInOnset30:
            return "30 push-ups in one set"
        case .pushupsInOnset50:
            return "50 push-ups in one set"
        }
    }
    
    var completedAdditionalText: String {
        switch self {
        case .pushups1000:
            return "You've done a total of 1,000 push-ups. Nice work!"
        case .pushups5000:
            return "You've done a total of 1,000 push-ups. Wow!"
        case .pushups10000:
            return "You've done a total of 1,000 push-ups. Astonishig!"
        case .workoutsInMonth5:
            return "You managed to do 5 workouts in one month. Good job!"
        case .workoutsInRow15:
            return "You managed to do 15 workouts in one month. You should be proud!"
        case .workoutsInRow25:
            return "You managed to do 25 workouts in one month. It's Remarkable!"
        case .oneTimePushups20:
            return "You did 20 push-ups in one workout! Not bad."
        case .oneTimePushups50:
            return "You did 50 push-ups in one workout! You are growing stronger."
        case .oneTimePushups100:
            return "You did 100 push-ups in one workout! It's Admirable!"
        case .workoutsInRow10:
            return "You've done your workouts 10 days in a row. Keep it up."
        case .workoutsInRow20:
            return "You've done your workouts 20 days in a row. You are second to none!"
        case .workoutsInRow50:
            return "You've done your workouts 50 days in a row. You are a titan!"
        case .totalduration1h:
            return "You've been doing push-ups for a total of one hour. There is something to be proud of."
        case .totalduration5h:
            return "You've been doing push-ups for a total of 5 hours. You are among the most persistent."
        case .totalduration10h:
            return "You've been doing push-ups for a total of 10 hours. You can start doing it full-time!"
        case .pushupsInOnset20:
            return "You did 20 push-ups in one set. Pretty good!"
        case .pushupsInOnset30:
            return "You did 30 push-ups in one set. You become unstoppable."
        case .pushupsInOnset50:
            return "You did 50 push-ups in one set. You have muscles of steel."
        }
    }
    
    var uncompletedAdditionalText: String {
        switch self {
        case .pushups1000:
            return "To receive this badge, you must complete 1000 push-ups in total."
        case .pushups5000:
            return "To receive this badge, you must complete 5000 push-ups in total."
        case .pushups10000:
            return "To receive this badge, you must complete 10000 push-ups in total."
        case .workoutsInMonth5:
            return "To receive this badge you must do at least 5 workouts in one month."
        case .workoutsInRow15:
            return "To receive this badge you must do at least 15 workouts in one month."
        case .workoutsInRow25:
            return "To receive this badge you must do at least 25 workouts in one month."
        case .oneTimePushups20:
            return "To receive this badge, you must perform at least 20 push-ups in one workout."
        case .oneTimePushups50:
            return "To receive this badge, you must perform at least 50 push-ups in one workout."
        case .oneTimePushups100:
            return "To receive this badge, you must perform at least 100 push-ups in one workout."
        case .workoutsInRow10:
            return "To get this badge, you need to complete workouts for 10 days in a row."
        case .workoutsInRow20:
            return "To get this badge, you need to complete workouts for 20 days in a row."
        case .workoutsInRow50:
            return "To get this badge, you need to complete workouts for 50 days in a row."
        case .totalduration1h:
            return "You must train for a total of one hour to receive this badge."
        case .totalduration5h:
            return "You must train for a total of 5 hour to receive this badge."
        case .totalduration10h:
            return "You must train for a total of 10 hour to receive this badge."
        case .pushupsInOnset20:
            return "To receive this badge, you must complete 20 push-ups in one training session."
        case .pushupsInOnset30:
            return "To receive this badge, you must complete 30 push-ups in one training session."
        case .pushupsInOnset50:
            return "To receive this badge, you must complete 50 push-ups in one training session."
        }
    }
}
