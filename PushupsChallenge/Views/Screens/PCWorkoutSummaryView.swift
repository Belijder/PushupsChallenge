//
//  PCWorkoutSummaryView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 03/07/2023.
//

import SwiftUI

struct PCWorkoutSummaryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var addBackgroundToSummary = false
    @State private var showActivityController = false
    @StateObject var vm: PCWorkoutSummaryViewViewModel
    
    var body: some View {
        ZStack {
            background
            summary
            shareButton
                .sheet(isPresented: $showActivityController, onDismiss: {
                    vm.capture = nil
                }) {
                    if let image = vm.capture {
                        ActivityViewController(activityItems: [image, vm.shareText])
                    }
                }
            closeButton
        }
    }
}

struct PCWorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PCWorkoutSummaryView(vm: PCWorkoutSummaryViewViewModel(workout: .example))
    }
}


extension PCWorkoutSummaryView {
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
                dismiss()
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
        Text("Workout Summary")
            .foregroundColor(.white)
            .font(.system(size: 30, weight: .bold))
        
    }
    
    private var totalReps: some View {
        VStack {
            Text("TOTAL REPS")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.totalReps)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: 100, weight: .black))
        }
    }
    
    
    private var sets: some View {
        HStack(spacing: 20) {
            ForEach(0..<(vm.sets.count), id: \.self) { index in
                VStack(spacing: 0) {
                    Text("Set \(index + 1)")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .fontWeight(.regular)
                    Text("\(vm.sets[index])")
                        .foregroundColor(.pcLightBlue)
                        .font(.system(size: 40))
                        .fontWeight(.black)
                }
            }
        }
    }
    
    
    private var duration: some View {
        VStack {
            Text("DURATION")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Text(vm.duration)
                .foregroundColor(.pcLightBlue)
                .font(.system(size: 70, weight: .black))
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
        .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    
    private var summary: some View {
        VStack(spacing: 50) {
            titleLabel
            totalReps
            sets
            duration
        }
        .padding(40)
        .padding(.top, 40)
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
    
}
