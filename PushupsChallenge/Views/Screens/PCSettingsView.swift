//
//  PCSettingsView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 26/06/2023.
//

import SwiftUI
import MessageUI

struct PCSettingsView: View {
    
    @StateObject var vm = PCSettingsViewViewModel()
    
    @State private var showStatistics = false
    @State private var showPreviewWorkouts = false
    @State private var showAchievements = false
    @State private var showRemindersView = false
    @State private var showTutorial = false
    @State private var showPreferencesView = false
    
    @State private var isShowingMailView = false
    
    
    var body: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .edgesIgnoringSafeArea(.all)
                .shadow(color: .black.opacity(0.4), radius: 3, x: 2)
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
                    preferences
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
                    .foregroundColor(.pcDarkBlue)
               
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
                    .foregroundColor(.pcDarkBlue)
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
                    .foregroundColor(.pcDarkBlue)
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
                    .foregroundColor(.pcDarkBlue)
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
                    .foregroundColor(.pcDarkBlue)
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
                vm.rateAppButtonTapped()
            } label: {
                Text("Write a review")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkBlue)
            }
            Spacer()
        }
    }
    
    
    private var supportCenterButton: some View {
        HStack {
            Button {
                MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : print("🔴 CANT SEND MAIL")
            } label: {
                Text("Support center")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkBlue)
            }
            Spacer()
        }
        .sheet(isPresented: $isShowingMailView) {
            PCMailViewController(isShowing: $isShowingMailView, result: $vm.result)
        }
    }
    
    
    private var tutorialButton: some View {
        HStack {
            Button {
                showTutorial = true
            } label: {
                Text("How to start")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkBlue)
            }
            .fullScreenCover(isPresented: $showTutorial) {
                PCTutorialView()
            }
            Spacer()
        }
    }
    
    
    private var preferences: some View {
        HStack {
            Button {
                showPreferencesView = true
            } label: {
                Text("Preferences")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.pcDarkBlue)
            }
            .fullScreenCover(isPresented: $showPreferencesView) {
                PCPreferencesView()
            }
            Spacer()
        }
    }
    
    
    private var termOfUseButton: some View {
        HStack {
            Button {
                //Open term of use
            } label: {
                Text("Term of use")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.pcDarkBlue)
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
                    .foregroundColor(.pcDarkBlue)
            }
            Spacer()
        }
    }
}
