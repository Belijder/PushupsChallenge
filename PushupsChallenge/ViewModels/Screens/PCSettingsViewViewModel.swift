//
//  PCSettingsViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 26/06/2023.
//

import Foundation
import MessageUI

final class PCSettingsViewViewModel: ObservableObject {
    @Published var result: Result<MFMailComposeResult, Error>? = nil
    
    
    func rateAppButtonTapped() {
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id6450920591?action=write-review")
               else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
