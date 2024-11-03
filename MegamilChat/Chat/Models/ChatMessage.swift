//
//  ChatMessage.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//

public struct ChatMessage: Equatable {
    var text: String
    var timestamp: String
    var isFromMe: Bool
    
    public init(text: String, timestamp: String, isFromMe: Bool) {
        self.text = text
        self.timestamp = timestamp
        self.isFromMe = isFromMe
    }
    
}
