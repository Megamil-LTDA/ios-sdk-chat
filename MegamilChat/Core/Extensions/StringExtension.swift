//
//  StringExtension.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 05/11/24.
//
import SwiftUI

extension String {
    func getHexaColor() -> Color {
        let hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        
        // Verifica se a string tem um comprimento válido
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else {
            return Color.clear
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        let alpha = hexSanitized.count == 8 ? Double((rgb & 0xFF000000) >> 24) / 255.0 : 1.0
        
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
