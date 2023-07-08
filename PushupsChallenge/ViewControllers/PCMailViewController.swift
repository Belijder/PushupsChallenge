//
//  PCMailViewController.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 04/07/2023.
//

import SwiftUI
import UIKit
import MessageUI

struct PCMailViewController: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PCMailViewController>) -> MFMailComposeViewController {
        let systemVersion = UIDevice.current.systemVersion
        let modelName = UIDevice.current.modelName
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        var titleMessage = "10K push-ups "
        titleMessage.append(appVersion ?? "n/a")
        titleMessage.append(", ")
        titleMessage.append(modelName)
        titleMessage.append(", ")
        titleMessage.append(systemVersion)
        
        
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["pushupschallenge10k@gmail.com"])
        vc.setSubject(titleMessage)
        vc.setMessageBody("<p>How can we help you?</p>", isHTML: true)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<PCMailViewController>) {
    }
}
