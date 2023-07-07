//
//  PCSetRemindersView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct PCSetRemindersView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notificationAccessGranded = false
    @StateObject var vm = PCSetRemindersViewViewModel()
    
    @ObservedResults(PCScheduledReminder.self, sortDescriptor: "day") var reminders
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient.pcBlueGradient
                .ignoresSafeArea()
            VStack() {
                navigationBar
                
                if notificationAccessGranded {
                    dayPicker
                    timePicker
                    actionButton
                    
                    if !reminders.isEmpty {
                        scheduledReminders
                    }
        
                } else {
                    messageForNoPermissionGranded
                }
            }
        }
        .onAppear {
            PCNotificationManager.shared.requestPermission(completion: { granded in
                    notificationAccessGranded = granded
            })
        }
    }
}

struct PCSetRemindersView_Previews: PreviewProvider {
    static var previews: some View {
        PCSetRemindersView()
    }
}

extension PCSetRemindersView {
    private var navigationBar: some View {
        ZStack(alignment: .top) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                Spacer()
            }
            VStack {
                Text("Set Reminders")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.black)
            }
        }
        .padding(.horizontal)
        .padding(.top, 6)
        .padding(.bottom, 10)
        .background(
            Color.pcDarkBlue
                .ignoresSafeArea()
                .shadow(radius: 3, y: 2)
        )
    }
    
    
    private var dayPicker: some View {
        VStack {
            Text("Select days for new reminders:")
                .foregroundColor(.pcDarkBlue)
                .font(.system(size: 15, weight: .black))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10) {
                ForEach(PCWeekday.allCases, id: \.self) { weekday in
                    Text(weekday.displayText.prefix(3))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(vm.selectedWeekdays.contains(weekday) ? .white : .pcDarkBlue)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(vm.selectedWeekdays.contains(weekday) ? Color.pcDarkBlue : .white.opacity(0.8))
                                .shadow(radius: 4, y: 4)
                        }
                        .onTapGesture {
                            withAnimation {
                                vm.weekdayItemTapped(weekday: weekday)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    
    private var timePicker: some View {
        DatePicker(selection: $vm.selectedDate, displayedComponents: [.hourAndMinute], label: {
            Text("Select time:")
                .foregroundColor(.pcDarkBlue)
                .font(.system(size: 15, weight: .black))
        })
        .tint(Color.pcDarkBlue)
        .padding()
    }
    
    
    private var actionButton: some View {
        Button {
            let schleduredReminders = vm.createReminders(for: vm.selectedWeekdays)
            for reminder in schleduredReminders {
                DispatchQueue.main.async {
                    withAnimation {
                        $reminders.append(reminder)
                    }
                }
            }
            vm.selectedWeekdays = []
        } label: {
            Text(vm.selectedWeekdays.count > 1 ? "Set reminders" : "Set reminder")
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue.opacity(vm.selectedWeekdays.isEmpty ? 0.4 : 1))
                        .shadow(radius: 4, y: 4)
                }
                
        }
        .padding(.horizontal)
        .disabled(vm.selectedWeekdays.isEmpty)
    }
    
    
    private var scheduledReminders: some View {
        VStack {
            Text("Scheduled reminders:")
                .foregroundColor(.pcDarkBlue)
                .font(.system(size: 15, weight: .black))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            List {
                ForEach(reminders) { reminder in
                    PCReminderCellView(reminder: reminder)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        PCNotificationManager.shared.removeNotificationFor(reminder: reminders[index])
                    }
                    withAnimation {
                        $reminders.remove(atOffsets: indexSet)
                    }
                })
            }
            .background(content: {
                Color.clear
            })
            .listStyle(PlainListStyle())
        }
    }
    
    
    private var messageForNoPermissionGranded: some View {
        VStack {
            Text("To set reminders, you must agree to receive notifications. Go to Settings > Notifications > 10K Push-ups and agree to get notifications.")
                .foregroundColor(.pcDarkBlue.opacity(0.4))
                .font(.system(.headline, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(60)
        }
        .frame(maxHeight: .infinity)
    }
}
