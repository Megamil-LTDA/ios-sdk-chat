//
//  OpenAiResponse.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//  let openAIResponse = try? JSONDecoder().decode(OpenAIResponse.self, from: jsonData)
import Foundation

// MARK: - OpenAIResponse
public struct OpenAIResponse: Codable {
    public let id, object: String?
    public let created: Int?
    public let model: String?
    public let choices: [OpenAIResponseChoice]?
    public let usage: OpenAIResponseUsage?
    public let systemFingerprint: String?
    
    func getMessage() -> ChatMessage {
        let message = choices?.first?.message?.content ?? ""
        
        // Desempacotar o `created` antes de usar no `Date`
        let timestamp: String
        if let created = created {
            let date = Date(timeIntervalSince1970: TimeInterval(created))
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            
            timestamp = dateFormatter.string(from: date)
        } else {
            timestamp = "Data não disponível"
        }
        
        return ChatMessage(text: message, timestamp: timestamp, isFromMe: false)
    }
    
    public enum CodingKeys: String, CodingKey {
        case id, object, created, model, choices, usage
        case systemFingerprint = "system_fingerprint"
    }
    
    public init(id: String?, object: String?, created: Int?, model: String?, choices: [OpenAIResponseChoice]?, usage: OpenAIResponseUsage?, systemFingerprint: String?) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
        self.usage = usage
        self.systemFingerprint = systemFingerprint
    }
}

// MARK: - Choice
public struct OpenAIResponseChoice: Codable {
    public let index: Int?
    public let message: OpenAIResponseMessage?
    public let logprobs, finishReason: String?
    
    public enum CodingKeys: String, CodingKey {
        case index, message, logprobs
        case finishReason = "finish_reason"
    }
    
    public init(index: Int?, message: OpenAIResponseMessage?, logprobs: String?, finishReason: String?) {
        self.index = index
        self.message = message
        self.logprobs = logprobs
        self.finishReason = finishReason
    }
}

// MARK: - Message
public struct OpenAIResponseMessage: Codable {
    public let role, content, refusal: String?
    
    public init(role: String?, content: String?, refusal: String?) {
        self.role = role
        self.content = content
        self.refusal = refusal
    }
}

// MARK: - Usage
public struct OpenAIResponseUsage: Codable {
    public let promptTokens, completionTokens, totalTokens: Int?
    public let promptTokensDetails: PromptTokensDetails?
    public let completionTokensDetails: CompletionTokensDetails?
    
    public enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
        case promptTokensDetails = "prompt_tokens_details"
        case completionTokensDetails = "completion_tokens_details"
    }
    
    public init(promptTokens: Int?, completionTokens: Int?, totalTokens: Int?, promptTokensDetails: PromptTokensDetails?, completionTokensDetails: CompletionTokensDetails?) {
        self.promptTokens = promptTokens
        self.completionTokens = completionTokens
        self.totalTokens = totalTokens
        self.promptTokensDetails = promptTokensDetails
        self.completionTokensDetails = completionTokensDetails
    }
}

// MARK: - CompletionTokensDetails
public struct CompletionTokensDetails: Codable {
    public let reasoningTokens: Int?
    
    public enum CodingKeys: String, CodingKey {
        case reasoningTokens = "reasoning_tokens"
    }
    
    public init(reasoningTokens: Int?) {
        self.reasoningTokens = reasoningTokens
    }
}

// MARK: - PromptTokensDetails
public struct PromptTokensDetails: Codable {
    public let cachedTokens: Int?
    
    public enum CodingKeys: String, CodingKey {
        case cachedTokens = "cached_tokens"
    }
    
    public init(cachedTokens: Int?) {
        self.cachedTokens = cachedTokens
    }
}
