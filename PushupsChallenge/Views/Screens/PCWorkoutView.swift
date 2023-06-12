//
//  PCWorkoutView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import SwiftUI

struct PCWorkoutView: View  {
    @StateObject var vm: PCWorkoutViewViewModel
    
    init(delegate: PCWorkoutViewViewModelProtocol?) {
        _vm = StateObject(wrappedValue: PCWorkoutViewViewModel(delegate: delegate))
    }
    
    var body: some View {
        ZStack {
            background
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    titleLabel
                    Spacer()
                    finishWorkoutButton
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                HStack {
                    workoutTimeLabel
                    Spacer()
                    currensSetLabel
                }
                .padding(.top, 10)
                .padding(.horizontal, 15)
                
                
                currentRepsCounter
                
                if vm.currentSet > 1 {
                    Spacer()
                    previousSetsLabel
                }
                
                Spacer()
                totalRepsLabel
            
                Spacer()
                breakButton

            }
            vm.overlayView
        }
        .frame(height: 380)
    }
}

struct PCWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PCMainView()
            VStack {
                Spacer()
                PCWorkoutView(delegate: PCMainViewViewModel())
            }
        }
    }
}

extension PCWorkoutView {
    private var background: some View {
        LinearGradient.pcBlueGradient
            .ignoresSafeArea(.all)
    }
    
    
    private var titleLabel: some View {
        Text("New Workout")
            .foregroundColor(.pcDarkViolet)
            .fontWeight(.semibold)
            .font(.system(size: 20))
    }
    
    
    private var finishWorkoutButton: some View {
        Button {
            vm.endWorkout()
        } label: {
            Text("Finish")
                .fontWeight(.medium)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(10)
                .padding(.horizontal, 15)
                .background {
                    LinearGradient.pcRedGradient
                        .cornerRadius(10)
                }
        }
    }
    
    
    private var workoutTimeLabel: some View {
        HStack {
            Text("Workout Time:")
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.light)
            Text(vm.displayedWorkoutTime)
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.black)
        }
    }
    
    
    private var currensSetLabel: some View {
        HStack {
            Text("Set:")
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.light)
            Text(String(vm.currentSet))
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.black)
        }
    }
    
    
    private var currentRepsCounter: some View {
        ZStack {
            Color.pcDarkBlue
                .frame(height: 130)
            VStack(alignment: .center, spacing: -5) {
                Text("Reps in current set")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                Text(String(vm.currentReps))
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                    .fontWeight(.black)
            }
            .padding(.top, 10)
        }
    }


    private var previousSetsLabel: some View {
        HStack {
            Text(vm.currentSet == 2 ? "Previous set:" : "Previous sets:")
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.light)
            Text(String(vm.displayedPreviousSets))
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.black)
        }
    }
    
    
    private var totalRepsLabel: some View {
        HStack {
            Text("Total reps:")
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.light)
            Text(String(vm.totalReps))
                .foregroundColor(.pcDarkViolet)
                .font(.system(size: 20))
                .fontWeight(.black)
        }
    }
    
    
    private var breakButton: some View {
        Button {
            vm.startBreak()
        } label: {
            Text("Take a break")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .padding()
                .padding(.horizontal, 30)
                .background {
                    LinearGradient.pcVioletGradient
                        .cornerRadius(10)
                }
        }
    }
    
}
