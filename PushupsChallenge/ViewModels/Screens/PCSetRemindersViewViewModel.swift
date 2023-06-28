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
    
    
    func createReminder(for weekday: PCWeekday, completion: @escaping (Result<PCScheduledReminder, Error>) -> Void) {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: selectedDate)
        dateComponents.weekday = weekday.rawValue + 1
        
        guard let hour = dateComponents.hour,
              let minute = dateComponents.minute
        else {
            return
        }
        
        let scheduledReminder = PCScheduledReminder()
        scheduledReminder.day = weekday
        scheduledReminder.hour = hour
        scheduledReminder.minute = minute
        
        PCNotificationManager.shared.createNotificationFor(reminder: scheduledReminder) { success in
            if success {
                completion(.success(scheduledReminder))
            }
        }
    }
}
