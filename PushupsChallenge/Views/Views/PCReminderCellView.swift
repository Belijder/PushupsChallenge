//
//  PCReminderCellView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct PCReminderCellView: View {
    @ObservedRealmObject var reminder: PCScheduledReminder
    
    var body: some View {
        HStack {
            Toggle(isOn: $reminder.activated) {
                Text("Every \(reminder.day.displayText) at \(reminder.stringTime)")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.pcDarkBlue)
                    .padding(.leading)
            }
            .padding()
            .onChange(of: reminder.activated, perform: { newValue in
                switch newValue {
                case true:
                    PCNotificationManager.shared.createNotificationFor(reminder: reminder) { _ in }
                case false:
                    PCNotificationManager.shared.removeNotificationFor(reminder: reminder)
                }
            })
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
            .tint(.pcDarkBlue)
        }
    }
}

struct PCReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .edgesIgnoringSafeArea(.all)
            PCReminderCellView(reminder: PCScheduledReminder.example)
        }
    }
}
