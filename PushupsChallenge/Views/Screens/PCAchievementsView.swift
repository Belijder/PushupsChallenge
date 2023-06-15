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
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ZStack {
            LinearGradient.pcVioletGradient
                .ignoresSafeArea()
            VStack {
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                        Spacer()
                    }
                    VStack {
                        Text("Achievements")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.black)
                    }
                }
                .padding(.horizontal)
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.achievementsViewModels, id: \.achievement.rawValue) { viewModel in
                            PCAchievementView(vm: viewModel)
                                .onTapGesture {
                                    viewModel.achievementWasTapped()
                                    withAnimation {
                                        viewModel.isSelected.toggle()
                                    }
                                }
                            
                        }
                    }
                }
            }
        }
    }
}

struct PCAchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        PCAchievementsView()
    }
}


enum PCAchievement: Int, CaseIterable {
    case pushups1000
    case pushups5000
    case pushups10000
    
    case workoutsInMonth5
    case workoutsInRow15
    case workoutsInRow25
    
    case oneTimePushups20
    case oneTimePushups50
    case oneTimePushups100
    
    case workoutsInRow10
    case workoutsInRow20
    case workoutsInRow50
    
    case totalduration1h
    case totalduration5h
    case totalduration10h
    
    case other1
    case other2
    case other3
    
    
    var unachievedImageName: String {
        return "achievement\(rawValue + 1)g"
    }
    
    var achievedImageName: String {
        return "achievement\(rawValue + 1)c"
    }
}
