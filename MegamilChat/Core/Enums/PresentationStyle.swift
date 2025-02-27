//
//  PresentationStyle.swift
//
//  Created by Eduardo dos santos on 01/11/24.
//
import SwiftUI

public enum PresentationStyle: String, Codable {
    case fullscreen = "fullscreen"
    case largeBottomSheet = "largebottomsheet"
    case mediumBottomSheet = "mediumbottomsheet"
    case smallBottomSheet = "smallbottomsheet"
    case floating = "floating"
    
    func sheetHeight() -> CGFloat {
        switch self {
            case .largeBottomSheet:
                return UIScreen.main.bounds.height * 0.9
            case .mediumBottomSheet:
                return UIScreen.main.bounds.height * 0.75
            case .smallBottomSheet:
                return UIScreen.main.bounds.height * 0.6
            case .fullscreen:
                return UIScreen.main.bounds.height
            case .floating:
                return UIScreen.main.bounds.height - 120
        }
    }
    
    var isBottomSheet: Bool {
        self != .floating && self != .fullscreen
    }
    
    var isFullScreen: Bool {
        self == .fullscreen
    }
    
    var isFloating: Bool {
        self == .floating
    }
    
    static func fromString(_ styleString: String) -> PresentationStyle {
        switch styleString.lowercased() {
            case "fullscreen":
                return .fullscreen
            case "largebottomsheet":
                return .largeBottomSheet
            case "mediumbottomsheet":
                return .mediumBottomSheet
            case "smallbottomsheet":
                return .smallBottomSheet
            case "floating":
                return .floating
            default:
                return .fullscreen
        }
    }
}
