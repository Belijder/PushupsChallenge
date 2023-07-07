//
//  MainView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/04/2023.
//

import SwiftUI

struct PCMainView: View {
    @ObservedObject var vm = PCMainViewViewModel()
    @State private var isMenuShown = false
    @State private var isTutorialShown = false
    @AppStorage("firstTimeRun") var isFirstTimeRun = true
    @AppStorage("mainCounter") var mainCounter = 10000
    
    
    var body: some View {
        ZStack {
            background
                .zIndex(0)
                
            VStack {
                achievementsButton
                    .fullScreenCover(isPresented: $vm.achievementsSheetIsPresented) {
                        PCAchievementsView()
                    }
                
                ZStack {
                    circleBackground
                    circleProgress
                    mainCounterLabel
                        .onAppear {
                            if isFirstTimeRun {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isTutorialShown = true
                                }
                            }
                        }
                        .fullScreenCover(isPresented: $isTutorialShown) {
                            isFirstTimeRun = false
                        } content: {
                            PCTutorialView()
                        }
                }
                .padding(.top, 50)
                
                if vm.workouts.last != nil {
                    Spacer()
                    lastWorkoutSummary
                        .fullScreenCover(isPresented: $vm.workoutsSummaryListISPresented) {
                            PCWorkoutsListView()
                        }
                }
                
                Spacer()
                startWorkoutButton
            }
            .sheet(isPresented: $vm.newWorkoutSheetIsPresented, content: {
                PCWorkoutView(delegate: vm)
                    .interactiveDismissDisabled()
                    .presentationDetents([.height(380)])
            })
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .frame(maxHeight: .infinity, alignment: .top)
            .zIndex(1)
            
            if isMenuShown {
                menuView
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
            
            menuButton
                .zIndex(3)
            
            if vm.showSummary {
                summaryOverlay
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PCMainView()
    }
}

extension PCMainView {
    private var background: some View {
        ZStack {
            Image("LaunchScreen")
                .resizable()
                .ignoresSafeArea()
            LinearGradient.pcVioletGradient.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
        }
        .onTapGesture {
            withAnimation {
                isMenuShown = false
            }
        }
    }
    
    
    private var menuButton: some View {
        VStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isMenuShown.toggle()
                }
            } label: {
                PCMenuButtonView(menuIsShown: $isMenuShown)
            }
            .padding(20)
            .background {
                Color.white.opacity(0.001)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
    
    
    private var achievementsButton: some View {
        HStack {
            Button {
                vm.achievementsSheetIsPresented = true
            } label: {
                Image(systemName: "medal.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .offset(CGSize(width: 5, height: -5))
            }
        }
        .frame(maxWidth: .infinity, alignment: .topTrailing)
    }
    
    
    private var circleBackground: some View {
        ZStack {
            Circle()
                .stroke(AngularGradient(gradient: Gradient(colors: [.pcDarkRed.opacity(0.1), .pcDarkRed.opacity(0.1), .pcLightRed.opacity(0.1), .pcDarkRed.opacity(0.1)]),
                                        center: .center),
                                        style: StrokeStyle(lineWidth: 15,
                                        lineCap: mainCounter > 9000 ? .butt : .round))
        }
        .frame(width: 220, height: 220)
    }
    
    
    private var circleProgress: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat(mainCounter) * 0.0001)
                .stroke(AngularGradient(gradient: Gradient(colors: [.pcDarkRed, .pcDarkRed, .pcLightRed, .pcDarkRed]),
                                        center: .center),
                                        style: StrokeStyle(lineWidth: 25,
                                                           lineCap: mainCounter > 9000 || mainCounter < 500 ? .butt : .round))
                .rotationEffect(.degrees(mainCounter > 9000 || mainCounter < 500 ? -90 : -85))
        }
        .frame(width: 220, height: 220)
    }
    

    private var mainCounterLabel: some View {
        Text("\(mainCounter)")
            .font(.largeTitle)
            .fontWeight(.black)
            .padding(50)
            .foregroundColor(.white)
    }
    
    
    private var startWorkoutButton: some View {
        Button {
            vm.newWorkoutSheetIsPresented = true
        } label: {
            ZStack {
                LinearGradient.pcRedGradient
                    .frame(height: 60)
                    .cornerRadius(10)
                    
                Text("Start Workout")
                    .foregroundColor(.white)
            }
            
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 30)
        .disabled(isFirstTimeRun)
    }
    
    
    private var lastWorkoutSummary: some View {
        VStack(spacing: 4) {
            Text("Last workout\(vm.workouts.last?.daysSinceLastTraining ?? "")")
                .font(.system(size: 16))
                .foregroundColor(.white)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .opacity(0.1)
                    .frame(height: 140)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.pcLightRed, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Workout time:")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.light)
                        Text(vm.workouts.last?.workoutDurationString ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.black)
                    }
                    HStack(spacing: 10) {
                        ForEach(0..<(vm.workouts.last?.reps.count ?? 0), id: \.self) { index in
                            VStack(spacing: 0) {
                                Text("Set \(index + 1)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 8))
                                    .fontWeight(.regular)
                                Text("\(vm.workouts.last?.reps[index] ?? 0)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .fontWeight(.black)
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 5) {
                        Text("Total reps:")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.light)
                        Text("\(vm.workouts.last?.totalReps ?? 0)")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.black)
                    }
                }
            }
            Button {
                vm.workoutsSummaryListISPresented = true
            } label: {
                Text("Show more workouts")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.pcLightBlue)
            }
        }
    }
    
    
    private var menuView: some View {
        PCSettingsView()
    }
    
    
    private var summaryOverlay: some View {
        VStack {
            if mainCounter == 0 {
                PCChallengeSummaryView(showSummary: $vm.showSummary)
            } else {
                PCWorkoutSummaryView(showSummary: $vm.showSummary, vm: PCWorkoutSummaryViewViewModel(workout: vm.lastWorkout!))
            }
        }
        .transition(.opacity)
        .zIndex(4)
    }
}
