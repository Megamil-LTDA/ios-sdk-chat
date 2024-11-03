//
//  MessageBubble.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct MessageBubble: View {
    var message: ChatMessage
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        VStack(alignment: message.isFromMe ? .trailing : .leading) {
            MessageContent(text: message.text,
                           timestamp: message.timestamp,
                           backgroundColor: backgroundColor,
                           textColor: textColor,
                           isFromMe: message.isFromMe)
        }
        .padding(.bottom, 4)
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
                .foregroundColor(.white)
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
