//
//  PCAchievementsView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import SwiftUI

struct PCAchievementsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PCAchievementsViewViewModel()
    @Namespace var namespace
    
    @State var showDetails = false
    @State var selectedBadge = 0
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ZStack {
            LinearGradient.pcVioletGradient
                .ignoresSafeArea()
                .zIndex(0)
            VStack {
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
                        Text("Achievements")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 6)
                .padding(.bottom, 10)
                .background(.ultraThinMaterial)
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.achievementsViewModels, id: \.badgeID) { viewModel in
                            Image(viewModel.imageName)
                                .resizable()
                                .matchedGeometryEffect(id: viewModel.badgeID, in: namespace)
                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                                .scaledToFit()
                                .shadow(radius: 5)
                                .onTapGesture {
                                    withAnimation {
                                        selectedBadge = viewModel.achievementType.rawValue
                                        showDetails.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .zIndex(1)
            
            if showDetails {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                showDetails.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 6)
                    Image(vm.achievementsViewModels[selectedBadge].imageName)
                        .resizable()
                        .matchedGeometryEffect(id: vm.achievementsViewModels[selectedBadge].badgeID, in: namespace)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .shadow(radius: 5)
                        .padding(.top, 20)
                    Text(vm.achievementsViewModels[selectedBadge].titleMessage)
                        .foregroundColor(.pcLightBlue)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30, weight: .black))
                        .padding(.horizontal, 30)
                    Text(vm.achievementsViewModels[selectedBadge].additionalText)
                        .foregroundColor(.pcLightBlue)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.horizontal, 30)
                        .padding(.top, 15)
                    Spacer()
                }
                .background(.ultraThinMaterial)
                .zIndex(2)
            }
        }
    }
}

struct PCAchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        PCAchievementsView()
    }
}
