//
//  PCWorkoutOverlayView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import SwiftUI

enum PCWorkoutOverlayViewType {
    case begin
    case `break`
    
    var counterValue: Int {
        switch self {
        case .begin:
            return 5
        case .break:
            let breakLenght = UserDefaults.standard.integer(forKey: "breakLenght")
            return breakLenght != 0 ? breakLenght : 30
        }
    }
    
    var displayTitle: String {
        switch self {
        case .begin:
            let languageNumber = UserDefaults.standard.integer(forKey: "voiceNumber")
            let voice = PCSpeechLanguage(rawValue: languageNumber)
            return voice?.getReadyText ?? "Get Ready!"
        case .break:
            return "Break"
        }
    }
}

struct PCWorkoutOverlayView: View {
    @StateObject var vm: PCWorkoutOverlayViewViewModel
    
    init(type: PCWorkoutOverlayViewType, delegate: PCWorkoutOverlayViewViewModelProtocol?) {
        _vm = StateObject(wrappedValue: PCWorkoutOverlayViewViewModel(type: type, delegate: delegate))
    }
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                Text(vm.displeyTitle)
                    .font(.system(size: vm.displeyTitle.count > 11 ? 30 : 40))
                    .fontWeight(.black)
                    .foregroundColor(.pcDarkBlue)
                Text(String(vm.displayedCounter))
                    .font(.system(size: vm.displayedCounter.count > 4 ? 40 : 160))
                    .multilineTextAlignment(.center)
                    .fontWeight(.black)
                    .foregroundColor(.pcDarkBlue)
            }
            VStack {
                Spacer()
                mainButton
            }
            
            if vm.type == .break {
                finishWorkoutButton
            }
        }
        .frame(height: 380)
    }
}

struct PCWorkoutViewOverlay_Previews: PreviewProvider {
    static var previews: some View {
        PCWorkoutOverlayView(type: .begin, delegate: nil)
    }
}


extension PCWorkoutOverlayView {
    private var background: some View {
        LinearGradient.pcBlueGradient
            .ignoresSafeArea(.all)
    }
    
    
    private var mainButton: some View {
        Button {
            vm.mainActionButtonTapped()
        } label: {
            Text(vm.mainButtonTitle)
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
    
    private var finishWorkoutButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    vm.invalidateTimer()
                    vm.delegate?.didTappedFinishWorkoutButton()
                } label: {
                    Text("Finish workout")
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
                .padding([.top, .trailing], 15)
            }
            Spacer()
        }
    }
}
