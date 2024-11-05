//
//  ChatInputView.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 04/11/24.
//

import SwiftUI

extension MegamilChatView {
    
    internal func chatInput() -> some View {
        ChatInput(
            messageText: $messageText,
            placeholder: config.placeholder,
            sendButtonIcon: config.sendButtonIcon,
            recordButtonIcon: config.recordButtonIcon,
            buttonColor: config.buttonColor,
            borderInputColor: config.borderInputColor,
            showInputBorder: config.showInputBorder,
            borderWidth: 1,
            onSend: {
                if !messageText.isEmpty && messageText != "" {
                    messages.append(ChatMessage(text: messageText, timestamp: DateHelper.formatCurrentDateTime(), isFromMe: true))
                    viewModel.sendMessage(message: messageText) { success, response in
                        if(success ?? false) {
                            messages.append(response!)
                        }
                    }
                    
                    messageText = ""
                    
                }
            },
            onRecord: {
                SafePrint("Iniciar gravação de áudio")
            },
            onKeyboardOpen: { isOpen in
                SafePrint("Teclado aberto")
            },
            allowAudioRecording: config.allowAudioRecording
        )
        .padding(.bottom, 22)
    }
    
}
