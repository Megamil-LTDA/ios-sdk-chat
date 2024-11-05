//
//  ChatInput.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct ChatInput: View {
    @Binding var messageText: String
    var placeholder: String = "Digite uma mensagem..."
    var sendButtonIcon: String = "paperplane.fill"
    var recordButtonIcon: String = "mic.fill"
    var buttonColor: Color = Color.blue
    var borderInputColor: [Color] = []
    var showInputBorder: Bool = true
    var borderWidth: CGFloat = 8.0
    var onSend: () -> Void
    var onRecord: () -> Void
    var onKeyboardOpen: (Bool) -> Void
    var allowAudioRecording: Bool = true
    @State private var keyboardIsVisible = false
    
    var body: some View {

        HStack {
            TextField(placeholder, text: $messageText)
                .padding(12)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.black)
                .placeholder(when: messageText.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }
                .onSubmit {
                    sendMessage()
                }
                .cornerRadius(8)
                .overlay(
                    showInputBorder ? BorderedColorsView(
                        cornerRadius: 8,
                        borderWidth: borderWidth,
                        colors: borderInputColor
                    ) : nil
                )
                .padding(.trailing, 8)
                .submitLabel(messageText == "" ? .send : .return) //@todo não funciona
                .onAppear {
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillShowNotification,
                        object: nil,
                        queue: .main
                    ) { _ in
                        keyboardIsVisible = true
                        onKeyboardOpen(true)
                    }
                    
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillHideNotification,
                        object: nil,
                        queue: .main
                    ) { _ in
                        keyboardIsVisible = false
                        onKeyboardOpen(false)
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self)
                }
                .onChangeCompat(of: messageText) { newValue in
                    SafePrint("newValue: \(newValue)")
                }
            
            if allowAudioRecording {
                if messageText.isEmpty {
                    setSendButton()
                } else {
                    
                }
            } else {
                setSendButton()
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 22)
    }
    
    private func setSendButton() -> some View {
        return
            Button(action: {
                if !messageText.isEmpty {
                    sendMessage()
                }
            }) {
                Image(systemName: sendButtonIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(8)
                    .background(messageText.isEmpty ? .gray : buttonColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }.disabled(messageText.isEmpty)
    }
    
    private func sendMessage() {
        onSend()
        messageText = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
