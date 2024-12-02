//
//  MessageBubble.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct MessageBubble: View {
    var message: ChatMessage
    var customMessage: String?
    var backgroundColor: Color
    var textColor: Color
    var typingSpeed: Double?
    
    @State private var displayedText = ""
    @State private var isTyping = false
    
    var body: some View {
        VStack(alignment: message.isFromMe ? .trailing : .leading) {
            MessageContent(text: displayedText,
                           timestamp: message.timestamp,
                           backgroundColor: backgroundColor,
                           textColor: textColor,
                           isFromMe: message.isFromMe)
        }
        .padding(.bottom, 4)
        .onAppear {
            startTypingEffect()
        }
    }
    
    private func startTypingEffect() {
        guard let typingSpeed = typingSpeed else {
                // Se a velocidade de digitação não for passada, apenas exibe o texto imediatamente.
            displayedText = customMessage ?? message.text
            return
        }
        
        let fullText = customMessage ?? message.text
        var index = 0
        Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if index < fullText.count {
                displayedText.append(fullText[fullText.index(fullText.startIndex, offsetBy: index)])
                index += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct MessageContent: View {
    var text: String
    var timestamp: String
    var backgroundColor: Color
    var textColor: Color
    var isFromMe: Bool
    
    var body: some View {
        VStack(alignment: isFromMe ? .trailing : .leading) {
            Text(timestamp)
                .font(.footnote)
                .foregroundColor(textColor.opacity(0.8))
                .multilineTextAlignment(isFromMe ? .trailing : .leading)
            
            Text(text)
                .foregroundColor(textColor)
                .multilineTextAlignment(isFromMe ? .trailing : .leading)
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(10, corners: isFromMe ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
        .frame(maxWidth: 250, alignment: isFromMe ? .trailing : .leading)
    }
}
