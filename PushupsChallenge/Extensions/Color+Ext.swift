//
//  Color+Ext.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 07/06/2023.
//

import SwiftUI

extension Color {
    static let pcDarkViolet = Color("darkViolet")
    static let pcViolet = Color("violet")
    static let pcDarkBlue = Color("darkBlue")
    static let pcLightBlue = Color("lightBlue")
    static let pcDarkRed = Color("darkRed")
    static let pcLightRed = Color("lightRed")
    
    
}

extension LinearGradient {
    static let pcVioletGradient = LinearGradient(colors: [.pcViolet, .pcDarkViolet, .pcDarkViolet], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let pcBlueGradient = LinearGradient(colors: [Color(red: 134/255, green: 244/255, blue: 238/255), .pcLightBlue], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let pcRedGradient  = LinearGradient(colors: [.pcLightRed, .pcDarkRed], startPoint: .bottomLeading, endPoint: .topTrailing)
}
