//
//  PCSetRemindersViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import Foundation

final class PCSetRemindersViewViewModel: ObservableObject {
    @Published var selectedWeekdays: [PCWeekday] = []
    @Published var selectedDate = Date()
    
    func weekdayItemTapped(weekday: PCWeekday) {
        guard let index = selectedWeekdays.firstIndex(where: { $0 == weekday }) else {
            selectedWeekdays.append(weekday)
            return
        }
        selectedWeekdays.remove(at: index)
    }
    

    func createReminders(for weekdays: [PCWeekday]) -> [PCScheduledReminder] {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        let group = DispatchGroup()
        var scheduledReminders: [PCScheduledReminder] = []
        
        for weekday in weekdays {
            group.enter()
            dateComponents.weekday = weekday.rawValue + 1
            
            guard let hour = dateComponents.hour,
                  let minute = dateComponents.minute
            else {
                continue
            }
            
            let scheduledReminder = PCScheduledReminder()
            scheduledReminder.day = weekday
            scheduledReminder.hour = hour
            scheduledReminder.minute = minute
            
            PCNotificationManager.shared.createNotificationFor(reminder: scheduledReminder) { success in
                defer {
                    group.leave()
                }
                
                if success {
                    scheduledReminders.append(scheduledReminder)
                    print("ScheduledFor \(weekday)")
                }
            }
        }
        
        group.wait()
        return scheduledReminders
    }
}
