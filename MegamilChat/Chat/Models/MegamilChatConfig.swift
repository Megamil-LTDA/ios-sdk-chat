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
    public var backgroundColor: Color
    public var canDragging, showBorder, showInputBorder, showReturnButton: Bool
    public var themName: String
    public var presentationStyle: PresentationStyle
    public var typeEndPoints: TypeEndPoints = .MegamilChat
    public var messages: [ChatMessage]
    public var suggestions: [String]
    public var placeholder: String
    public var sendButtonIcon: String
    public var recordButtonIcon: String
    public var buttonColor: Color
    public var borderColor: [Color]
    public var borderInputColor: [Color]
    public var ref: String
    public var name: String
    public var contact: String
    public var baseUrl: String
    public var endpoint: String
    public var bearerToken: String
    public var allowAudioRecording: Bool
    public var meBubbleColor: Color
    public var meBubbleTextColor: Color
    public var themBubbleColor: Color
    public var themBubbleTextColor: Color
    
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
        backgroundColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .backgroundColor) ?? "#FFFFFF")
        canDragging = try container.decodeIfPresent(Bool.self, forKey: .canDragging) ?? true
        showBorder = try container.decodeIfPresent(Bool.self, forKey: .showBorder) ?? true
        showInputBorder = try container.decodeIfPresent(Bool.self, forKey: .showInputBorder) ?? true
        showReturnButton = try container.decodeIfPresent(Bool.self, forKey: .showReturnButton) ?? true
        themName = try container.decodeIfPresent(String.self, forKey: .themName) ?? ""
        presentationStyle = PresentationStyle.fromString(try container.decodeIfPresent(String.self, forKey: .presentationStyle) ?? "fullscreen")
        typeEndPoints = TypeEndPoints.fromString(try container.decodeIfPresent(String.self, forKey: .typeEndPoints) ?? "typeEndPoints")
        messages = try container.decodeIfPresent([ChatMessage].self, forKey: .messages) ?? []
        suggestions = try container.decodeIfPresent([String].self, forKey: .suggestions) ?? []
        placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder) ?? "Digite uma mensagem..."
        sendButtonIcon = try container.decodeIfPresent(String.self, forKey: .sendButtonIcon) ?? "paperplane.fill"
        recordButtonIcon = try container.decodeIfPresent(String.self, forKey: .recordButtonIcon) ?? "mic.fill"
        buttonColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .buttonColor) ?? "#0000FF")
        borderColor = (try container.decodeIfPresent([String].self, forKey: .borderColor) ?? ["#008000", "#0000FF", "#FF0000"]).map { Color(hex: $0) }
        borderInputColor = (try container.decodeIfPresent([String].self, forKey: .borderInputColor) ?? ["#FFA500", "#FFC0CB", "#808080"]).map { Color(hex: $0) }
        ref = try container.decodeIfPresent(String.self, forKey: .ref) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        contact = try container.decodeIfPresent(String.self, forKey: .contact) ?? ""
        baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl) ?? ""
        endpoint = try container.decodeIfPresent(String.self, forKey: .endpoint) ?? ""
        bearerToken = try container.decodeIfPresent(String.self, forKey: .bearerToken) ?? ""
        allowAudioRecording = try container.decodeIfPresent(Bool.self, forKey: .allowAudioRecording) ?? false
        meBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleColor) ?? "#0000FF")
        meBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleTextColor) ?? "#FFFFFF")
        themBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleColor) ?? "#008000")
        themBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleTextColor) ?? "#FFFFFF")
    }

}
