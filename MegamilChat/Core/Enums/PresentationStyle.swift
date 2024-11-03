//
//  PresentationStyle.swift
//
//  Created by Eduardo dos santos on 01/11/24.
//
import SwiftUI

public enum PresentationStyle {
    case fullscreen
    case largeBottomSheet
    case mediumBottomSheet
    case smallBottomSheet
    case floating
    
    func sheetHeight() -> CGFloat {
        switch self {
            case .largeBottomSheet:
                return UIScreen.main.bounds.height * 0.9
            case .mediumBottomSheet:
                return UIScreen.main.bounds.height * 0.75
            case .smallBottomSheet:
                return UIScreen.main.bounds.height * 0.5
            case .fullscreen:
                return UIScreen.main.bounds.height
            case .floating:
                return UIScreen.main.bounds.height - 128
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
    
}
