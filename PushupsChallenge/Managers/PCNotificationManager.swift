//
//  PCNotificationManager.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import Foundation
import UserNotifications

final class PCNotificationManager {
    static let shared = PCNotificationManager()
    init() {}
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granded, _ in
            completion(granded)
        }
    }
    
    
    func createNotificationFor(reminder: PCScheduledReminder, completion: @escaping (Bool) -> Void) {
        let content = UNMutableNotificationContent()
        content.title = "Hey! You know what time is it?"
        content.body = "It is time to do some pushups!"
        content.interruptionLevel = .critical
        content.sound = .defaultCritical
        
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = reminder.day.rawValue + 1
        dateComponents.hour = reminder.hour
        dateComponents.minute = reminder.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: reminder.notificationID, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
    func removeNotificationFor(reminder: PCScheduledReminder) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [reminder.notificationID])
    }
}
