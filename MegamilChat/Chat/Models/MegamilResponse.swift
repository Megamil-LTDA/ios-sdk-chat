//
//  MegamilResponse.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
//  let megamilResponse = try? JSONDecoder().decode(MegamilResponse.self, from: jsonData)

import Foundation

// MARK: - MegamilResponse
public struct MegamilResponse: Codable {
    public let data: MegamilResponseData?
    public let message, msg: String?
    public let status: Int?
    
    func getMessage() -> ChatMessage {
        let message = message ?? data?.answer ?? ""
        let timestamp = DateHelper.formatCurrentDateTime()
        return ChatMessage(text: message, timestamp: timestamp, isFromMe: false)
    }
    
    public init(data: MegamilResponseData?, message: String?, msg: String?, status: Int?) {
        self.data = data
        self.message = message
        self.msg = msg
        self.status = status
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? values.decode(MegamilResponseData.self, forKey: .data)
        self.message = try? values.decode(DecodableUtil.self, forKey: .message).stringValue()
        self.msg = try? values.decode(DecodableUtil.self, forKey: .msg).stringValue()
        self.status = try? values.decode(DecodableUtil.self, forKey: .status).intValue()
    }
    
}

// MARK: - MegamilResponseData
public struct MegamilResponseData: Codable {
    public let answer, audioResponse, question: String?
    
    public enum CodingKeys: String, CodingKey {
        case answer
        case audioResponse = "audio_response"
        case question
    }
    
    public init(answer: String?, audioResponse: String?, question: String?) {
        self.answer = answer
        self.audioResponse = audioResponse
        self.question = question
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.answer = try? values.decode(DecodableUtil.self, forKey: .answer).stringValue()
        self.audioResponse = try? values.decode(DecodableUtil.self, forKey: .audioResponse).stringValue()
        self.question = try? values.decode(DecodableUtil.self, forKey: .question).stringValue()
    }
    
}

