//
//  MegamilChatConfig.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 05/11/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let megamilChatConfig = try? JSONDecoder().decode(MegamilChatConfig.self, from: jsonData)

import SwiftUI
import Foundation

// MARK: - MegamilChatConfig
public struct MegamilChatConfig: Codable {
    public let backgroundColor: Color
    public let canDragging, showBorder, showInputBorder, showReturnButton: Bool
    public let themName: String
    public let presentationStyle: PresentationStyle
    public var typeEndPoints: TypeEndPoints = .MegamilChat
    public let messages: [ChatMessage]
    public let suggestions: [String]
    public let placeholder: String
    public let sendButtonIcon: String
    public let recordButtonIcon: String
    public let buttonColor: Color
    public let borderColor: [Color]
    public let borderInputColor: [Color]
    public let ref: String
    public let name: String
    public let contact: String
    public let baseUrl: String
    public let endpoint: String
    public let bearerToken: String
    public let allowAudioRecording: Bool
    public let meBubbleColor: Color
    public let meBubbleTextColor: Color
    public let themBubbleColor: Color
    public let themBubbleTextColor: Color

   // onClose: (() -> Void)? = nil,
   // typeEndPoints: TypeEndPoints = .MegamilChat,
    
    public init(
        backgroundColor: String = "#FFFFFF",
        canDragging: Bool = true,
        showBorder: Bool = true,
        showInputBorder: Bool = true,
        showReturnButton: Bool = true,
        themName: String = "",
        presentationStyle: String = "fullscreen",
        typeEndPoints: String = "typeEndPoints",
        messages: [ChatMessage] = [],
        suggestions: [String] = [],
        placeholder: String = "Digite uma mensagem...",
        sendButtonIcon: String = "paperplane.fill",
        recordButtonIcon: String = "mic.fill",
        buttonColor: String = "#0000FF",
        borderColor: [String] = ["#008000", "#0000FF", "#FF0000"],
        borderInputColor: [String] = ["#FFA500", "#FFC0CB", "#808080"],
        ref: String = "",
        name: String = "",
        contact: String = "",
        baseUrl: String = "",
        endpoint: String = "",
        bearerToken: String = "",
        allowAudioRecording: Bool = false,
        meBubbleColor: String = "#0000FF",
        meBubbleTextColor: String = "#FFFFFF",
        themBubbleColor: String = "#008000",
        themBubbleTextColor: String = "#FFFFFF"
    ) {
        self.backgroundColor = Color(hex: backgroundColor)
        self.canDragging = canDragging
        self.showBorder = showBorder
        self.showInputBorder = showInputBorder
        self.showReturnButton = showReturnButton
        self.themName = themName
        self.presentationStyle = PresentationStyle.fromString(presentationStyle)
        self.typeEndPoints = TypeEndPoints.fromString(typeEndPoints)
        self.messages = messages
        self.suggestions = suggestions
        self.placeholder = placeholder
        self.sendButtonIcon = sendButtonIcon
        self.recordButtonIcon = recordButtonIcon
        self.buttonColor = Color(hex: buttonColor)
        self.borderColor = borderColor.map { Color(hex: $0) }
        self.borderInputColor = borderInputColor.map { Color(hex: $0) }
        self.ref = ref
        self.name = name
        self.contact = contact
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.bearerToken = bearerToken
        self.allowAudioRecording = allowAudioRecording
        self.meBubbleColor = Color(hex: meBubbleColor)
        self.meBubbleTextColor = Color(hex: meBubbleTextColor)
        self.themBubbleColor = Color(hex: themBubbleColor)
        self.themBubbleTextColor = Color(hex: themBubbleTextColor)
    }
    
        // Codificação manual das cores como hexadecimal
    enum CodingKeys: String, CodingKey {
        case backgroundColor, canDragging, showBorder, showInputBorder, showReturnButton, themName, presentationStyle, typeEndPoints, messages, suggestions, placeholder, sendButtonIcon, recordButtonIcon, buttonColor, borderColor, borderInputColor,
             ref, name, contact, baseUrl, endpoint, bearerToken, allowAudioRecording, meBubbleColor, meBubbleTextColor, themBubbleColor, themBubbleTextColor
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(backgroundColor.toHex(), forKey: .backgroundColor)
        try container.encode(canDragging, forKey: .canDragging)
        try container.encode(showBorder, forKey: .showBorder)
        try container.encode(showInputBorder, forKey: .showInputBorder)
        try container.encode(showReturnButton, forKey: .showReturnButton)
        try container.encode(themName, forKey: .themName)
        try container.encode(presentationStyle, forKey: .presentationStyle)
        try container.encode(typeEndPoints, forKey: .typeEndPoints)
        try container.encode(messages, forKey: .messages)
        try container.encode(suggestions, forKey: .suggestions)
        try container.encode(placeholder, forKey: .placeholder)
        try container.encode(sendButtonIcon, forKey: .sendButtonIcon)
        try container.encode(recordButtonIcon, forKey: .recordButtonIcon)
        try container.encode(buttonColor.toHex(), forKey: .buttonColor)
        try container.encode(borderColor.map { $0.toHex() }, forKey: .borderColor)
        try container.encode(borderInputColor.map { $0.toHex() }, forKey: .borderInputColor)
        try container.encode(ref, forKey: .ref)
        try container.encode(name, forKey: .name)
        try container.encode(contact, forKey: .contact)
        try container.encode(baseUrl, forKey: .baseUrl)
        try container.encode(endpoint, forKey: .endpoint)
        try container.encode(bearerToken, forKey: .bearerToken)
        try container.encode(allowAudioRecording, forKey: .allowAudioRecording)
        try container.encode(meBubbleColor.toHex(), forKey: .meBubbleColor)
        try container.encode(meBubbleTextColor.toHex(), forKey: .meBubbleTextColor)
        try container.encode(themBubbleColor.toHex(), forKey: .themBubbleColor)
        try container.encode(themBubbleTextColor.toHex(), forKey: .themBubbleTextColor)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backgroundColor = Color(hex: try container.decode(String.self, forKey: .backgroundColor))
        canDragging = try container.decode(Bool.self, forKey: .canDragging)
        showBorder = try container.decode(Bool.self, forKey: .showBorder)
        showInputBorder = try container.decode(Bool.self, forKey: .showInputBorder)
        showReturnButton = try container.decode(Bool.self, forKey: .showReturnButton)
        themName = try container.decode(String.self, forKey: .themName)
        presentationStyle = PresentationStyle.fromString(try container.decode(String.self, forKey: .presentationStyle))
        typeEndPoints = TypeEndPoints.fromString(try container.decode(String.self, forKey: .typeEndPoints))
        messages = try container.decode([ChatMessage].self, forKey: .messages)
        suggestions = try container.decode([String].self, forKey: .suggestions)
        placeholder = try container.decode(String.self, forKey: .placeholder)
        sendButtonIcon = try container.decode(String.self, forKey: .sendButtonIcon)
        recordButtonIcon = try container.decode(String.self, forKey: .recordButtonIcon)
        buttonColor = Color(hex: try container.decode(String.self, forKey: .buttonColor))
        borderColor = try container.decode([String].self, forKey: .borderColor).map { Color(hex: $0) }
        borderInputColor = try container.decode([String].self, forKey: .borderInputColor).map { Color(hex: $0) }
        ref = try container.decode(String.self, forKey: .ref)
        name = try container.decode(String.self, forKey: .name)
        contact = try container.decode(String.self, forKey: .contact)
        baseUrl = try container.decode(String.self, forKey: .baseUrl)
        endpoint = try container.decode(String.self, forKey: .endpoint)
        bearerToken = try container.decode(String.self, forKey: .bearerToken)
        allowAudioRecording = try container.decode(Bool.self, forKey: .allowAudioRecording)
        meBubbleColor = Color(hex: try container.decode(String.self, forKey: .meBubbleColor))
        meBubbleTextColor = Color(hex: try container.decode(String.self, forKey: .meBubbleTextColor))
        themBubbleColor = Color(hex: try container.decode(String.self, forKey: .themBubbleColor))
        themBubbleTextColor = Color(hex: try container.decode(String.self, forKey: .themBubbleTextColor))
    }
}

/*
 {
 "backgroundColor": "#FFFFFF",
 "canDragging": true,
 "showBorder": true,
 "showInputBorder": true,
 "showReturnButton": true,
 "themName": "Nome do Tema",
 "presentationStyle": "fullscreen",
 "messages": [
 {
 "text": "Olá, como você está?",
 "timestamp": "2024-11-05T10:00:00Z",
 "isFromMe": true
 },
 {
 "text": "Estou bem, obrigado!",
 "timestamp": "2024-11-05T10:00:01Z",
 "isFromMe": false
 }
 ],
 "suggestions": [
 "Como posso ajudar você?",
 "Qual é a sua dúvida?"
 ],
 "placeholder": "Digite uma mensagem...",
 "sendButtonIcon": "paperplane.fill",
 "recordButtonIcon": "mic.fill",
 "buttonColor": "#0000FF",
 "borderColor": ["#008000", "#0000FF", "#FF0000"],
 "borderInputColor": ["#FFA500", "#FFC0CB", "#808080"],
 "allowAudioRecording": false,
 "meBubbleColor": "#0000FF",
 "meBubbleTextColor": "#FFFFFF",
 "themBubbleColor": "#008000",
 "themBubbleTextColor": "#FFFFFF"
 }
*/
