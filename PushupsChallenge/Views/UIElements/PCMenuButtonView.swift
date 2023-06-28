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
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 25, height: 3)
                .rotationEffect(menuIsShown ? .degrees(45) : .degrees(0))
                .offset(CGSize(width: 0, height: menuIsShown ? 8 : 0))
                .foregroundColor(menuIsShown ? .pcDarkViolet : .white)
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 25, height: 3)
                .opacity(menuIsShown ? 0 : 1)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 25, height: 3)
                .rotationEffect(menuIsShown ? .degrees(-45) : .degrees(0))
                .offset(CGSize(width: 0, height: menuIsShown ? -8 : 0))
                .foregroundColor(menuIsShown ? .pcDarkViolet : .white)
        }
    }
}

struct pcMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PCMenuButtonView(menuIsShown: .constant(false))
    }
}

