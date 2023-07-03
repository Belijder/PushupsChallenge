//
//  PCPreferencesView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 30/06/2023.
//

import SwiftUI

struct PCPreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = PCPreferencesViewViewModel()
    @State private var showConfirmationDialog = false
    
    
    var body: some View {
        ZStack {
            LinearGradient.pcBlueGradient
                .ignoresSafeArea()
                .zIndex(0)
            VStack {
                navigationBar
                VStack(spacing: 12) {
                    breakLenghtPicker
                    voicePicker
                    Spacer()
                    resetDataButton
                    
                }
                .padding()
                Spacer()
            }
            .zIndex(1)
            
            if vm.showConfirmationMessage {
                confirmationMessage
                    .transition(.opacity)
                    .zIndex(2)
            }
        }
        .overlay {
            if vm.showProgressView {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.pcDarkBlue)
            }
        }
    }
}


struct PCPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PCPreferencesView()
    }
}


extension PCPreferencesView {
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
                Text("Preferences")
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
        )
    }
    
    
    private var breakLenghtPicker: some View {
        HStack {
            Text("Break lenght")
                .font(.system(size: 15))
                .foregroundColor(.pcDarkBlue)
            Spacer()
            Picker("Select break lenght", selection: $vm.breakLenght) {
                Text("15s").tag(15)
                Text("30s").tag(30)
                Text("45s").tag(45)
                Text("1m").tag(60)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .labelsHidden()
            .tint(Color.pcDarkBlue)
            .pickerStyle(.menu)
        }
        .padding(8)
        .padding(.leading, 10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.6))
        }
    }
    
    
    private var voicePicker: some View {
        HStack {
            Text("Voice")
                .font(.system(size: 15))
                .foregroundColor(.pcDarkBlue)
            Spacer()
            Picker("Select voice", selection: $vm.selectedVoice) {
                ForEach(PCSpeechLanguage.allCases, id: \.rawValue) { voice in
                    Text(voice.titleLabel).tag(voice.rawValue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .labelsHidden()
            .tint(Color.pcDarkBlue)
            .pickerStyle(.menu)
        }
        .padding(8)
        .padding(.leading, 10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.6))
        }
    }
    
    
    private var resetDataButton: some View {
        Button {
            showConfirmationDialog = true
        } label: {
            Text("Delete all app data")
                .foregroundColor(.pcDarkRed)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background {
                    Color.white.opacity(0.6)
                        .cornerRadius(8)
                }
        }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmationDialog) {
            Button("Delete all data", role: .destructive) {
                withAnimation {
                    vm.deleteAllAppData()
                }
            }
        } message: {
            Text("This will delete all data from the app, including any workouts you've done. This action cannot be undone.")
        }
    }
    
    
    private var confirmationMessage: some View {
        VStack(spacing: 10) {
            Image(systemName: "checkmark")
                .foregroundColor(.pcDarkViolet.opacity(0.5))
                .font(.system(size: 50, weight: .regular))
            Text("Successfully deleted.")
                .multilineTextAlignment(.center)
                .foregroundColor(.pcDarkViolet.opacity(0.5))
                .padding(.horizontal, 20)
        }
        .frame(width: 200, height: 150)
        .background {
            Color.white.opacity(0.4)
                .cornerRadius(16)
        }
    }
}
