//
//  PCStatisticsView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 19/06/2023.
//

import SwiftUI
import Charts
import RealmSwift

struct PCStatisticsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PCStatisticsViewViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .ignoresSafeArea()
            
            VStack {
                navigationBar
                if vm.workouts.count > 9 {
                    ScrollView {
                        VStack(spacing: 16) {
                            statisticOfMostPushupsInWorkout
                            PCPushupsAverangeStatisticsView()
                            statisticOfMostPushupsInSet
                            PCPushupsAveragePerSetStatisticsView()
                            PCChallengeCompletionPercentageStatisticsView()
                            statisticOfLongestSeriesOfWorkout
                            statisticOfMostActivMonth
                            statisticOfTotalWorkoutsDuration
                        }
                        .padding(.top, 10)
                        
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal)
                } else {
                    Spacer()
                    Text("Stats will be available after completing at least ten workouts.")
                        .foregroundColor(.pcDarkBlue.opacity(0.4))
                        .font(.system(.headline, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(50)
                    Spacer()
                }
            }
        }
    }
}

struct PCStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        PCStatisticsView()
    }
}


extension PCStatisticsView {
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
                Text("Statistics")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.black)
            }
        }
        .padding(.horizontal)
        .padding(.top, 6)
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
    }
    
    
    private var statisticOfMostPushupsInWorkout: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Most push-ups in one workout")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            HStack {
                VStack {
                    Text(vm.mostPushupsInOneWorkoutValue)
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue)
                        .shadow(radius: 4, y: 4)
                }
                
                VStack(alignment: .leading) {
                    Text(vm.mostPushupsInOneWorkoutDate)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(height: 60)
                .padding(.leading, 20)

                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
        }
    }
    
    
    private var statisticOfMostPushupsInSet: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Most push-ups in one set")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            HStack {
                VStack {
                    Text(vm.mostPushupsInOneSetValue)
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue)
                        .shadow(radius: 4, y: 4)
                }
                
                VStack(alignment: .leading) {
                    Text(vm.mostPushupsInOneSetDate)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(height: 60)
                .padding(.leading, 20)
                
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
        }
    }
    
    
    private var statisticOfLongestSeriesOfWorkout: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("The longest streak of workout days in a row")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            HStack {
                VStack {
                    Text(vm.longestSeriesOfWorkoutsValue)
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue)
                        .shadow(radius: 4, y: 4)
                }
                
                VStack(alignment: .leading) {
                    Text(vm.longestSeriesOfWorkoutsStartDay + " - " + vm.longestSeriesOfWorkoutsEndDay)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(height: 60)
                .padding(.leading, 20)

                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
        }
    }
    
    
    private var statisticOfTotalWorkoutsDuration: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Total duration of all workouts")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            HStack {
                VStack {
                    Text(vm.totalDurationOfWorkouts)
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                }
                .frame(width: vm.totalDurationOfWorkouts.count < 4 ? 100 : 150, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue)
                        .shadow(radius: 4, y: 4)
                }
                
                VStack {
                    Text("This month")
                        .font(.system(size: 8, weight: .regular))
                        .foregroundColor(.pcDarkBlue)
                    Text(vm.durationOfWorkoutsThisMonth)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(width: 80, height: 60)
                
                VStack {
                    Text("This week")
                        .font(.system(size: 8, weight: .regular))
                        .foregroundColor(.pcDarkBlue)
                    Text(vm.durationOfWorkoutsThisWeek)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(width: 80, height: 60)
                
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
        }
    }
    
    
    private var statisticOfMostActivMonth: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Most workouts in one month")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.pcDarkBlue.opacity(0.8))
            HStack {
                VStack {
                    Text(vm.workoutsInMostActivMonth)
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pcDarkBlue)
                        .shadow(radius: 4, y: 4)
                }
                
                VStack(alignment: .leading) {
                    Text(vm.mostActivMonth)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.pcDarkBlue)
                }
                .frame(height: 60)
                .padding(.leading, 20)
                
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8))
            }
        }
    }
}
