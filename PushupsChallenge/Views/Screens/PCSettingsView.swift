//
//  PCSettingsView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 26/06/2023.
//

import SwiftUI



struct PCSettingsView: View {
    
    @StateObject var vm = PCSettingsViewViewModel()
    
    @State private var showStatistics = false
    @State private var showPreviewWorkouts = false
    @State private var showAchievements = false
    @State private var showRemindersView = false
    @State private var showTutorial = false
    @State var breakLenghtSelection = 2
    
    var body: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .edgesIgnoringSafeArea(.all)
            titleLabel
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    previeusWorkoutsButton
                    statisticsButton
                    achievementsButton
                    setRemindersButton
                    writeReviewButton
                    supportCenterButton
                    tutorialButton
                    breakLenghtPicker
                }
                Spacer()
                termOfUseButton
                privacyPolicyButton
                
            }
            .padding(.top, 100)
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .padding(.trailing, 100)
    }
}

struct PCSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PCSettingsView()
    }
}


extension PCSettingsView {
    private var titleLabel: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer()
                Text("Settings")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(.pcDarkViolet)
               
            }
            Spacer()
        }
        .padding(20)
    }
    
    
    private var previeusWorkoutsButton: some View {
        HStack {
            Button {
                showPreviewWorkouts = true
            } label: {
                Text("Previeus workouts")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            .fullScreenCover(isPresented: $showPreviewWorkouts) {
                PCWorkoutsListView()
            }
            Spacer()
        }
    }
    
    
    private var statisticsButton: some View {
        HStack {
            Button {
                showStatistics = true
            } label: {
                Text("Statistics")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            .fullScreenCover(isPresented: $showStatistics) {
                PCStatisticsView()
            }
            Spacer()
        }
    }
    
    
    private var achievementsButton: some View {
        HStack {
            Button {
                showAchievements = true
            } label: {
                Text("Achievements")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            .fullScreenCover(isPresented: $showAchievements) {
                PCAchievementsView()
            }
            Spacer()
        }
    }
    
    
    private var setRemindersButton: some View {
        HStack {
            Button {
                showRemindersView = true
            } label: {
                Text("Set reminders")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            .fullScreenCover(isPresented: $showRemindersView) {
                PCSetRemindersView()
            }
            Spacer()
        }
    }
    
    
    private var writeReviewButton: some View {
        HStack {
            Button {
                //Open AppStore for review
            } label: {
                Text("Write a review")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            Spacer()
        }
    }
    
    
    private var supportCenterButton: some View {
        HStack {
            Button {
                //Open mailbox
            } label: {
                Text("Support center")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            Spacer()
        }
    }
    
    
    private var tutorialButton: some View {
        HStack {
            Button {
                showTutorial = true
            } label: {
                Text("How to start")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkViolet)
            }
            .fullScreenCover(isPresented: $showTutorial) {
                //Show Tutorial View
            }
            Spacer()
        }
    }
    
    
    private var breakLenghtPicker: some View {
        HStack {
            Text("Break lenght")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.pcDarkViolet)
            Spacer()
            Picker("Select break lenght", selection: $breakLenghtSelection) {
                Text("15s").tag(1)
                Text("30s").tag(2)
                Text("45s").tag(3)
                Text("1m").tag(4)
            }
            .frame(width: 80)
            .tint(Color.pcDarkBlue)
            .pickerStyle(.menu)
        }
    }
    
    
    private var termOfUseButton: some View {
        HStack {
            Button {
                //Open term of use
            } label: {
                Text("Term of use")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.pcDarkViolet)
            }
            Spacer()
        }
    }
    
    
    private var privacyPolicyButton: some View {
        HStack {
            Button {
                //Open privacy polocy
            } label: {
                Text("Privacy Policy")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.pcDarkViolet)
            }
            Spacer()
        }
    }
}
