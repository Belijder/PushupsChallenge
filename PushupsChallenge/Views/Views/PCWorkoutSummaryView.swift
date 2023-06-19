//
//  PCWorkoutSummaryView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 16/06/2023.
//

import SwiftUI
import RealmSwift

struct PCWorkoutSummaryView: View {
    
    @StateObject var vm: PCWorkoutSummaryViewViewModel
    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                date
                sets
                HStack {
                    repsCounter
                    Spacer()
                    duration
                }
            }
            .zIndex(0)
            
            if isEditing {
                deleteButton
                    .zIndex(1)
            }
        }
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.pcDarkBlue.gradient)
        }
    }
}

struct PCWorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PCWorkoutSummaryView(vm: PCWorkoutSummaryViewViewModel(workout: PCWorkout.example), isEditing: .constant(true))
    }
}


extension PCWorkoutSummaryView {
    
    private var date: some View {
        Text(vm.workoutDate)
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
    }
    
    private var sets: some View {
        HStack(spacing: 20) {
            ForEach(0..<(vm.sets.count), id: \.self) { index in
                VStack(spacing: 0) {
                    Text("Set \(index + 1)")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                        .fontWeight(.regular)
                    Text("\(vm.sets[index])")
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                        .fontWeight(.black)
                }
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 10)
    }
    
    private var repsCounter: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("Total reps:")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.light)
            Text("\(vm.totalReps)")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.black)
        }
        .padding(10)
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial)
        .cornerRadius(8)
    }
    
    private var duration: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("Duration:")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.light)
            Text("\(vm.duration)")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.black)
        }
        .padding(10)
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial)
        .cornerRadius(8)
    }
    
    private var deleteButton: some View {
        Button {
            vm.deleteWorkout()
            PCAchievementsManager.shared.checkAchievementsCompletion()
        } label: {
            Image(systemName: "trash")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(12)
                .background {
                    Color.pcDarkRed
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
        }
    }
}
