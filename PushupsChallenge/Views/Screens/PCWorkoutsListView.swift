//
//  PCWorkoutsListView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 16/06/2023.
//

import SwiftUI
import RealmSwift

enum PCWorkoutFilterOption: String, CaseIterable {
    case week = "This week"
    case month = "This month"
    case all = "All"
    
    var textForEmptyFilterResult: String {
        switch self {
        case .week:
            return "You haven't done push-ups this week. Do some workout."
        case .month:
            return "You haven't done push-ups this month. Shame on you! Go and change it now!"
        case .all:
            return "You don't have any workouts yet. Go ahead, do your first workout!"
        }
    }
}

struct PCWorkoutsListView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = PCWorkoutsListViewViewModel()
    @Namespace private var namespace
    @State var isEditing = false
    
    @ObservedResults(PCWorkout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var workouts
    
    
    var body: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .ignoresSafeArea()
            VStack {
                navigationBar
                filterOptionPicker
                workoutsSummaryList
            }
        }
    }
}

struct PCWorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        PCWorkoutsListView()
        
    }
}


extension PCWorkoutsListView {
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
                Button {
                    withAnimation {
                        isEditing.toggle()
                    }
                } label: {
                    Text(isEditing ? "Done" : "Edit")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.pcDarkViolet)
                        }
                }

            }
            VStack {
                Text("Workouts")
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
    
    
    private var filterOptionPicker: some View {
        HStack {
            ForEach(PCWorkoutFilterOption.allCases, id: \.rawValue) { option in
                ZStack {
                    if vm.selectedFilterOption == option {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pcDarkViolet)
                            .matchedGeometryEffect(id: "optionBackground", in: namespace)
                    }
                    Text(option.rawValue)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 35)
                .onTapGesture {
                    withAnimation(.spring()) {
                        vm.selectedFilterOption = option
                    }
                }
            }
        }
        .background(content: {
            Color.pcDarkBlue.opacity(0.3)
                .cornerRadius(10)
        })
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    
    private var workoutsSummaryList: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                if !vm.filteredWorkout.isEmpty {
                    ForEach(workouts.where( { workout in
                        if vm.selectedFilterOption == .week {
                            return workout.date >= vm.thisWeekStartDate()
                        } else if  vm.selectedFilterOption == .month {
                            return workout.date >= vm.thisMonthStartDate()
                        } else {
                            return workout.totalReps >= 0
                        }
                    } )) { workout in
                        PCWorkoutSummaryView(vm: PCWorkoutSummaryViewViewModel(workout: workout), isEditing: $isEditing)
                    }
                } else {
                    Text(vm.textForEmptyState)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.pcDarkBlue.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .scrollIndicators(.never, axes: .vertical)
        .padding(.horizontal)
    }
    
}
