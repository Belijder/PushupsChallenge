//
//  pcMenuButtonView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 08/06/2023.
//

import SwiftUI

struct PCMenuButtonView: View {
    
    @Binding var menuIsShown: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Color.white
                .frame(width: 25, height: 3)
                .cornerRadius(2)
                .rotationEffect(menuIsShown ? .degrees(45) : .degrees(0))
                .offset(CGSize(width: 0, height: menuIsShown ? 8 : 0))
            Color.white
                .frame(width: 25, height: 3)
                .cornerRadius(2)
                .opacity(menuIsShown ? 0 : 1)
            Color.white
                .frame(width: 25, height: 3)
                .cornerRadius(2)
                .rotationEffect(menuIsShown ? .degrees(-45) : .degrees(0))
                .offset(CGSize(width: 0, height: menuIsShown ? -8 : 0))
        }
    }
}

struct pcMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PCMenuButtonView(menuIsShown: .constant(true))
    }
}

