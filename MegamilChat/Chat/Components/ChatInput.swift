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
    var borderColor: [Color] = []
    var showBorder: Bool = true
    var borderWidth: CGFloat = 8.0
    var onSend: () -> Void
    var onRecord: () -> Void
    var onKeyboardOpen: (Bool) -> Void
    var allowAudioRecording: Bool = true
    @State private var submitLabel: SubmitLabel = .send
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
                    showBorder ? BorderedColorsView(
                        cornerRadius: 8,
                        borderWidth: borderWidth,
                        colors: borderColor
                    ) : nil
                )
                .padding(.trailing, 8)
                .submitLabel(submitLabel)
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
                .onChange(of: messageText) { newValue in
                    SafePrint("newValue: \(newValue)")
                    submitLabel = newValue.isEmpty ? .return : .send
                }
            
            if allowAudioRecording {
                if messageText.isEmpty {
                    Button(action: {
                        onRecord()
                    }) {
                        Image(systemName: recordButtonIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(8)
                            .background(buttonColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                } else {
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
                            .background(buttonColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
            } else {
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
                        .background(buttonColor)
                        .foregroundColor(messageText.isEmpty ? .gray : .white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .disabled(messageText.isEmpty)
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 22)
    }
    
    private func sendMessage() {
        onSend()
        messageText = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
