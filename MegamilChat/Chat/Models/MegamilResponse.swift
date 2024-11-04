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
}

