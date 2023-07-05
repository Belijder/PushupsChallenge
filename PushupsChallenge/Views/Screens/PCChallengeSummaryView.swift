//
//  PCChallengeSummaryView.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 04/07/2023.
//

import SwiftUI

struct PCChallengeSummaryView: View {
    @StateObject var vm = PCChallengeSummaryViewViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PCChallengeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PCChallengeSummaryView()
    }
}
