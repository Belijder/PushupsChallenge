//
//  PCTutorialView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 03/07/2023.
//

import SwiftUI

struct PCTutorialView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient.pcVioletGradient
                .ignoresSafeArea()
            VStack {
                Text("How to start?")
                    .padding()
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .bold))
                VStack(spacing: UIDevice.isSmallerModel() ? 30 : 40) {
                    step1
                    step2
                    step3
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack {
                actionButton
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
                
        }
    }
}

struct PCTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        PCTutorialView()
        PCTutorialView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
    }
}

extension PCTutorialView {
    private var step1: some View {
        VStack(spacing: 15) {
            Image(systemName: "1.circle")
                .foregroundColor(.pcLightBlue)
                .font(.system(size: 30))
            Text("Put your phone on the floor \nand press Start Workout button.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: UIDevice.isSmallerModel() ? 12 : 16, weight: .medium))
                .padding(.horizontal, 40)
        }
    }
    
    
    private var step2: some View {
        VStack(spacing: 15) {
            Image(systemName: "2.circle")
                .foregroundColor(.pcLightBlue)
                .font(.system(size: 30))
            Text("Get into the position in which you will perform push-ups so that the phone is between your hands at the height of your chest.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: UIDevice.isSmallerModel() ? 12 : 16, weight: .medium))
                .padding(.horizontal, 40)
            Image("TutorialImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 70)
        }
    }
    
    
    private var step3: some View {
        VStack(spacing: 15) {
            Image(systemName: "3.circle")
                .foregroundColor(.pcLightBlue)
                .font(.system(size: 30))
            Text("Do push-up until you hear a sound confirming the completion of the repetition.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: UIDevice.isSmallerModel() ? 12 : 16, weight: .medium))
                .padding(.horizontal, 40)
        }
    }
    
    
    private var actionButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                LinearGradient.pcRedGradient
                    .frame(height: 60)
                    .cornerRadius(10)
                    
                Text("Understand")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 70)
        .padding(.bottom, 30)
    }
}
