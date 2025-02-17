//
//  ChatMessage.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//

public struct ChatMessage: Codable, Equatable {
    var text: String
    var timestamp: String
    var isFromMe: Bool
    
    enum CodingKeys: String, CodingKey {
        case text
        case timestamp
        case isFromMe
        case isFromMeUnderscore = "is_from_me"
    }
    
    public init(text: String, timestamp: String, isFromMe: Bool) {
        self.text = text
        self.timestamp = timestamp
        self.isFromMe = isFromMe
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        text = try container.decode(String.self, forKey: .text)
        timestamp = try container.decode(String.self, forKey: .timestamp)
        
        if let isFromMeValue = try container.decodeIfPresent(Bool.self, forKey: .isFromMe) {
            isFromMe = isFromMeValue
        } else if let isFromMeValue = try container.decodeIfPresent(Bool.self, forKey: .isFromMeUnderscore) {
            isFromMe = isFromMeValue
        } else {
            isFromMe = false
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(isFromMe, forKey: .isFromMe)
    }
}
