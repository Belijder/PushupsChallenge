//
//  PCChallengeSummaryView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 04/07/2023.
//

import SwiftUI

struct PCChallengeSummaryView: View {
    @Binding var showSummary: Bool
    @State private var addBackgroundToSummary = false
    @State private var showActivityController = false
    @StateObject var vm = PCChallengeSummaryViewViewModel()
    
    var body: some View {
        ZStack {
            background
            summary
                .onAppear(perform: vm.calculateValues)
            VStack(spacing: 20) {
                shareButton
                    .sheet(isPresented: $showActivityController, onDismiss: {
                        vm.capture = nil
                    }) {
                        if let image = vm.capture {
                            ActivityViewController(activityItems: [image, vm.shareText])
                        }
                    }
                startAgainButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 30)
        }
    }
}

struct PCChallengeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PCChallengeSummaryView(showSummary: .constant(true))
        
        PCChallengeSummaryView(showSummary: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
    }
}

extension PCChallengeSummaryView {
    private var background: some View {
        ZStack {
            Image("LaunchScreen")
                .resizable()
            .ignoresSafeArea()
            LinearGradient.pcVioletGradient.opacity(0.9)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    
    private var closeButton: some View {
        VStack {
            Button {
                showSummary = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    
    private var titleLabel: some View {
        Text("Challenge completed!")
            .foregroundColor(.white)
            .font(.system(size: UIDevice.isSmallerModel() ? 25 : 30, weight: .bold))
    }
    
    
    private var totalPushups: some View {
        VStack {
            Text("TOTAL PUSH-UPS")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.totalPushupsString)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: UIDevice.isSmallerModel() ? 60 : 80, weight: .black))
        }
    }
    
    
    private var totalWorkouts: some View {
        VStack {
            Text("TOTAL WORKOUTS")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.totalWorkoutsString)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: UIDevice.isSmallerModel() ? 40 : 60, weight: .black))
        }
    }
    
    
    private var daysSinceFirstWorkout: some View {
        VStack {
            Text("DAYS SINCE FIRST WORKOUT")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.daysSinceFirstWorkoutString)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: UIDevice.isSmallerModel() ? 40 : 60, weight: .black))
        }
    }
    
    
    private var totalDurationduration: some View {
        VStack {
            Text("TOTAL WORKOUTS DURATION")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.totalWorkoutsDurationString)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: UIDevice.isSmallerModel() ? 32 : 42, weight: .black))
        }
    }
    
    
    private var summary: some View {
        VStack {
            VStack(spacing: UIDevice.isSmallerModel() ? 20 : 30) {
                titleLabel
                totalPushups
                totalWorkouts
                daysSinceFirstWorkout
                totalDurationduration
            }
            
        }
        .padding([.horizontal, .bottom], 40)
        .padding(.top, addBackgroundToSummary == true ? 80 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            if addBackgroundToSummary {
                ZStack {
                    Image("LaunchScreen")
                        .resizable()
                    .ignoresSafeArea()
                    LinearGradient.pcVioletGradient.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .overlay(alignment: .top) {
            if addBackgroundToSummary {
                logoOverlay
                    .padding(.top, 20)
            }
        }
    }
    
    
    private var logoOverlay: some View {
        HStack {
            Text("10K")
                .font(.system(size: 42, weight: .black))
                .foregroundColor(.white)
            VStack(spacing: 0) {
                Text("push-ups")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.pcLightBlue)
                Text("challenge")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.pcLightBlue)
            }
            .offset(y: -2)
        }
    }
    
    
    private var shareButton: some View {
        VStack {
            Button {
                addBackgroundToSummary = true
                let renderer = ImageRenderer(content: summary)
                renderer.scale = 3
                vm.capture = renderer.uiImage
                addBackgroundToSummary = false
                showActivityController = true
            } label: {
                ZStack {
                    LinearGradient.pcRedGradient
                        .frame(height: 60)
                        .cornerRadius(10)
                    
                    Text("Share")
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 50)
        }
    }
    
    
    private var startAgainButton: some View {
        VStack {
            Button {
                vm.startChallengeAgain()
                showSummary = false
            } label: {
                ZStack {
                    LinearGradient.pcRedGradient.opacity(0.01)
                        .frame(height: 60)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(LinearGradient.pcRedGradient, lineWidth: 1)
                                
                        }
                    
                    Text("Start Again")
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 50)
        }
    }
}
