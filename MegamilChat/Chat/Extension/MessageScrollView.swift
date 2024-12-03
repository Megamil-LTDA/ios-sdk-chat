//
//  MessageScrollView.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 04/11/24.
//
import SwiftUI

extension MegamilChatView {
    internal func messageScrollView() -> some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack(spacing: 10) {
                        // Sugestões
                    if messages.isEmpty && !suggestions.isEmpty {
                        VStack(spacing: 10) {
                            Text("Sugestões")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            
                            ForEach(suggestions, id: \.self) { suggestion in
                                Text(suggestion)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        addSuggestionToMessages(suggestion)
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    }
                    
                    Spacer(minLength: 0)
                    
                    LazyVStack(spacing: 8) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            HStack {
                                if message.isFromMe {
                                    MessageBubble(
                                        message: message,
                                        backgroundColor: config.meBubbleColor,
                                        textColor: config.meBubbleTextColor
                                    )
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                } else {
                                    let customMessage = config.themName != ""
                                    ? "\(config.themName) \(message.text)"
                                    : message.text
                                    
                                    MessageBubble(
                                        message: message,
                                        customMessage: customMessage,
                                        backgroundColor: config.themBubbleColor,
                                        textColor: config.themBubbleTextColor,
                                        typingSpeed: config.typingEffect ? 0.035 : nil
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 10)
                }
                .onChange(of: messages) { newMessages in
                    if let lastMessageIndex = newMessages.indices.last {
                        withAnimation {
                            scrollProxy.scrollTo(lastMessageIndex, anchor: .bottom)
                        }
                    }
                }
                .frame(minHeight: UIScreen.main.bounds.height - 190)
            }
        }
    }


    
    internal func addSuggestionToMessages(_ suggestion: String) {
        messages.append(ChatMessage(
            text: suggestion,
            timestamp: DateHelper.formatCurrentDateTime(),
            isFromMe: true
        ))
        viewModel.sendMessage(message: suggestion) { success, response in
            if success ?? false, let responseMessage = response {
                messages.append(responseMessage)
            }
        }
    }
}
