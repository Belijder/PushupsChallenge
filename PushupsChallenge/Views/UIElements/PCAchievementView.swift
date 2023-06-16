//
//  PCAchievementView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 14/06/2023.
//

import SwiftUI

struct PCAchievementView: View {
    
    @StateObject var vm: PCAchievementViewViewModel
    var body: some View {
        Image(vm.imageName)
            .resizable()
            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
            .scaledToFit()
            .shadow(radius: 5)
//            .zIndex(vm.isSelected ? 100 : 0)
    }
}

struct PCAchievementView_Previews: PreviewProvider {
    static var previews: some View {
        PCAchievementView(vm: PCAchievementViewViewModel(achievement: .oneTimePushups100, isCompleted: true))
    }
}
