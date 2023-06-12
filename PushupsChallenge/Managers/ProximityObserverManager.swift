//
//  ProximityObserverManager.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 12/06/2023.
//

import UIKit

protocol Countable: AnyObject {
    func changeCountNumber()
}

final class ProximityObserverManager {
    weak var delegate: Countable?
    
    @objc func didChange(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if device.proximityState == true {
                delegate?.changeCountNumber()
            }
        }
    }
    
    func activateProximitySensor() {
        print("activateProximitySensor")
        UIDevice.current.isProximityMonitoringEnabled = true
        
        if UIDevice.current.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(self.didChange), name: UIDevice.proximityStateDidChangeNotification, object: UIDevice.current)
        }
    }
    
    func deactivateProximitySensor() {
        print("deactivateProximitySensor")
        UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self, name: UIDevice.proximityStateDidChangeNotification, object: UIDevice.current)
    }
}
