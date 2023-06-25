//
//  MainView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/04/2023.
//

import SwiftUI

struct PCMainView: View {
    @ObservedObject var vm = PCMainViewViewModel()
    @State private var isMenuShown = true
    @State private var showStatistics = false
    
    var body: some View {
        ZStack {
            background
                .zIndex(0)
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    achievementsButton
                        .fullScreenCover(isPresented: $vm.achievementsSheetIsPresented) {
                            PCAchievementsView()
                        }
                }
                Spacer()
                ZStack {
                    circleProgress
                    mainCounter
                }
                Spacer()
                if vm.workouts.last != nil {
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
            .zIndex(1)
            
            if isMenuShown {
                menuView
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
            
            VStack {
                HStack(alignment: .top) {
                    menuButton
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .zIndex(3)
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
    }
    
    
    private var menuButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                isMenuShown.toggle()
            }
        } label: {
            PCMenuButtonView(menuIsShown: $isMenuShown)
        }
    }
    
    
    private var achievementsButton: some View {
        Button {
            vm.achievementsSheetIsPresented = true
        } label: {
            Image(systemName: "medal.fill")
                .foregroundColor(.white)
                .font(.system(size: 25))
                .offset(CGSize(width: 5, height: -3))
        }
    }
    
    
    private var circleProgress: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat(vm.mainCounter) * 0.0001)
                .stroke(AngularGradient(gradient: Gradient(colors: [.pcDarkRed, .pcDarkRed, .pcLightRed, .pcDarkRed]),
                                        center: .center),
                                        style: StrokeStyle(lineWidth: 25,
                                        lineCap: vm.mainCounter > 9000 ? .butt : .round))
                .rotationEffect(.degrees(vm.mainCounter > 9000 ? -90 : -85))
        }
        .frame(width: 220, height: 220)
    }
    

    private var mainCounter: some View {
        Text("\(vm.mainCounter)")
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
        ZStack {
            LinearGradient.pcBlueGradient
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Button {
                    showStatistics = true
                } label: {
                    Text("Statistics")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.pcDarkBlue)
                }
                .fullScreenCover(isPresented: $showStatistics) {
                    PCStatisticsView()
                }
            }
            .padding(.top, 100)
            .padding(.horizontal)
        }
        .padding(.trailing, 100)
    }
}
