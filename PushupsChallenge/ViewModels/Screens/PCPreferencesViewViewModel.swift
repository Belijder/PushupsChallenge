//
//  PCPreferencesViewViewModel.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 30/06/2023.
//

import SwiftUI
import RealmSwift

final class PCPreferencesViewViewModel: ObservableObject {
    @Published var showConfirmationMessage = false
    @Published var showProgressView = false
    
    @Published var breakLenght: Int {
        didSet {
            UserDefaults.standard.set(breakLenght, forKey: "breakLenght")
        }
    }
    
    @Published var selectedVoice = UserDefaults.standard.integer(forKey: "voiceNumber") {
        didSet {
            UserDefaults.standard.set(selectedVoice, forKey: "voiceNumber")
        }
    }
    
    
    init() {
        breakLenght = UserDefaults.standard.integer(forKey: "breakLenght") == 0 ? 30 : UserDefaults.standard.integer(forKey: "breakLenght")
    }
    
    
    func deleteAllAppData() {
        showProgressView = true
        let realm = try! Realm()
        let workouts = realm.objects(PCWorkout.self)
        
        try! realm.write {
            realm.delete(workouts)
        }
        
        UserDefaults.standard.set(10000, forKey: "mainCounter")
        
        showProgressView = false
        showConfirmationMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.showConfirmationMessage = false
            }
        }

        print("All data deleted")
    }
}
