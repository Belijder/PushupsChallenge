//
//  UIDevice+Ext.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 04/07/2023.
//

import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    static func isSmallerModel() -> Bool {
        let deviceModel = UIDevice.current.model
        let deviceName = UIDevice.current.name

        if deviceModel == "iPhone" && deviceName.contains("SE") || deviceName.contains("mini") || deviceName.contains("8") || deviceName.contains("X") {
            return true
        } else {
            return false
        }
    }
}
