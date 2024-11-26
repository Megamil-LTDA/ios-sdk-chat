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
                LazyVStack(alignment: .center) {
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
                                    .blur(radius: 0.5)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    }
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(messages.indices.reversed(), id: \.self) { index in
                            HStack {
                                let message = messages[index]
                                if(message.isFromMe) {
                                    MessageBubble(message: message, backgroundColor: config.meBubbleColor, textColor: config.meBubbleTextColor)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .scaleEffect(y: -1)
                                } else {
                                    let customMessage = config.themName != "" ? "\(config.themName) \(message.text)" : message.text
                                    MessageBubble(message: message, customMessage: customMessage, backgroundColor: config.themBubbleColor, textColor: config.themBubbleTextColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .scaleEffect(y: -1)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 4)
                        }
                    }
                    .scaleEffect(y: -1)
                    .padding(.top, 10)
                    .onChangeCompat(of: config.messages) { newMessages in
                        if let lastMessageIndex = newMessages.indices.last {
                            withAnimation {
                                scrollProxy.scrollTo(lastMessageIndex, anchor: .bottom)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    
    internal func addSuggestionToMessages(_ suggestion: String) {
        messages.append(ChatMessage(text: suggestion, timestamp: DateHelper.formatCurrentDateTime(), isFromMe: true))
        viewModel.sendMessage(message: suggestion) { success, response in
            if success ?? false, let responseMessage = response {
                messages.append(responseMessage)
            }
        }
    }
}
