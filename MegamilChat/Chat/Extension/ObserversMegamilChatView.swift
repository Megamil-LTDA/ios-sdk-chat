//
//  ObserversMegamilChatView.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 04/11/24.
//
import SwiftUI

extension MegamilChatView {
    
    internal func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                var fixHeight = 0.0
                switch presentationStyle {
                    case .fullscreen:
                        fixHeight = 0.0
                        SafePrint("fullscreen")
                    case .floating:
                        fixHeight = 30.0
                        SafePrint("floating")
                    case .largeBottomSheet:
                        fixHeight = 60.0
                        SafePrint("largeBottomSheet")
                    case .mediumBottomSheet:
                        fixHeight = 100.0
                        SafePrint("mediumBottomSheet")
                    case .smallBottomSheet:
                        fixHeight = 240.0
                        SafePrint("smallBottomSheet")
                }
                keyboardHeight = keyboardFrame.height - fixHeight
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
    
    internal func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
