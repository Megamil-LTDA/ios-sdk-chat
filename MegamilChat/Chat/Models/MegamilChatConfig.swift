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
public struct ChatConfigModel: Codable {
    public let status: Int?
    public let msg: String?
    public let data: MegamilChatConfig?
    
    public init(status: Int?, msg: String?, data: MegamilChatConfig?) {
        self.status = status
        self.msg = msg
        self.data = data
    }
}

public struct MegamilChatConfig: Codable {
    public var backgroundColor: Color = Color(hex: "FFFFFFFF")
    public var canDragging: Bool = true
    public var showBorder: Bool = true
    public var showInputBorder: Bool = true
    public var showReturnButton: Bool = true
    public var typingEffect: Bool = true
    public var themName: String = ""
    public var presentationStyle: PresentationStyle = .fullscreen
    public var typeEndpoints: TypeEndpoints = .MegamilChat
    public var messages: [ChatMessage] = []
    public var listSuggestions: [String]?
    public var placeholder: String = L10n.enterAMessage
    public var sendButtonIcon: String = "paperplane.fill"
    public var recordButtonIcon: String = "mic.fill"
    public var buttonColor: Color = Color(hex: "#0000FF")
    public var listBorderColors: [Color] = []
    public var listInputBorderColors: [Color] = []
    public var ref: String = ""
    public var name: String = ""
    public var contact: String = ""
    public var baseUrl: String = ""
    public var endpoint: String = ""
    public var bearerToken: String = ""
    public var allowAudioRecording: Bool = false
    public var meBubbleColor: Color = Color(hex: "0000FFFF")
    public var meBubbleTextColor: Color = Color(hex: "FFFFFFFF")
    public var themBubbleColor: Color = Color(hex: "008000FF")
    public var themBubbleTextColor: Color = Color(hex: "FFFFFFFF")
    
    public enum CodingKeys: String, CodingKey {
        case backgroundColor = "background_color"
        case canDragging = "can_dragging"
        case showBorder = "show_border"
        case showInputBorder = "show_input_border"
        case showReturnButton = "show_return_button"
        case typingEffect = "typing_effect"
        case themName = "them_name"
        case presentationStyle = "presentation_style"
        case typeEndpoints = "type_endpoints"
        case messages
        case listSuggestions = "list_suggestions"
        case placeholder
        case sendButtonIcon = "send_button_icon"
        case recordButtonIcon = "record_button_icon"
        case buttonColor = "button_color"
        case listBorderColors = "list_border_colors"
        case listInputBorderColors = "list_input_border_colors"
        case ref
        case name
        case contact
        case baseUrl = "base_url"
        case endpoint
        case bearerToken = "bearer_token"
        case allowAudioRecording = "allow_audio_recording"
        case meBubbleColor = "me_bubble_color"
        case meBubbleTextColor = "me_bubble_text_color"
        case themBubbleColor = "them_bubble_color"
        case themBubbleTextColor = "them_bubble_text_color"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backgroundColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .backgroundColor) ?? "FFFFFFFF")
        canDragging = try container.decodeIfPresent(Bool.self, forKey: .canDragging) ?? true
        showBorder = try container.decodeIfPresent(Bool.self, forKey: .showBorder) ?? true
        showInputBorder = try container.decodeIfPresent(Bool.self, forKey: .showInputBorder) ?? true
        showReturnButton = try container.decodeIfPresent(Bool.self, forKey: .showReturnButton) ?? true
        typingEffect = try container.decodeIfPresent(Bool.self, forKey: .typingEffect) ?? true
        themName = try container.decodeIfPresent(String.self, forKey: .themName) ?? ""
        presentationStyle = PresentationStyle.fromString(try container.decodeIfPresent(String.self, forKey: .presentationStyle) ?? "fullscreen")
        typeEndpoints = TypeEndpoints.fromString(try container.decodeIfPresent(String.self, forKey: .typeEndpoints) ?? "MegamilChat")
        messages = try container.decodeIfPresent([ChatMessage].self, forKey: .messages) ?? []
        
        if let suggestionsArray = try? container.decodeIfPresent([String].self, forKey: .listSuggestions) {
            listSuggestions = suggestionsArray
        } else if let suggestionsString = try? container.decodeIfPresent(String.self, forKey: .listSuggestions) {
            listSuggestions = suggestionsString.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        }
        
        placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder) ?? L10n.enterAMessage
        sendButtonIcon = try container.decodeIfPresent(String.self, forKey: .sendButtonIcon) ?? "paperplane.fill"
        recordButtonIcon = try container.decodeIfPresent(String.self, forKey: .recordButtonIcon) ?? "mic.fill"
        buttonColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .buttonColor) ?? "#0000FF")
        
        if let borderColorsArray = try? container.decodeIfPresent([String].self, forKey: .listBorderColors) {
            listBorderColors = borderColorsArray.map { Color(hex: $0) }
        } else if let borderColorsString = try? container.decodeIfPresent(String.self, forKey: .listBorderColors) {
            listBorderColors = borderColorsString.split(separator: ",").map { Color(hex: String($0)) }
        }
        
        if let inputBorderColorsArray = try? container.decodeIfPresent([String].self, forKey: .listInputBorderColors) {
            listInputBorderColors = inputBorderColorsArray.map { Color(hex: $0) }
        } else if let inputBorderColorsString = try? container.decodeIfPresent(String.self, forKey: .listInputBorderColors) {
            listInputBorderColors = inputBorderColorsString.split(separator: ",").map { Color(hex: String($0)) }
        }
        
        ref = try container.decodeIfPresent(String.self, forKey: .ref) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        contact = try container.decodeIfPresent(String.self, forKey: .contact) ?? ""
        baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl) ?? ""
        endpoint = try container.decodeIfPresent(String.self, forKey: .endpoint) ?? ""
        bearerToken = try container.decodeIfPresent(String.self, forKey: .bearerToken) ?? ""
        allowAudioRecording = try container.decodeIfPresent(Bool.self, forKey: .allowAudioRecording) ?? false
        meBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleColor) ?? "0000FFFF")
        meBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleTextColor) ?? "FFFFFFFF")
        themBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleColor) ?? "008000FF")
        themBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleTextColor) ?? "FFFFFFFF")
    }
    
    public init(
        backgroundColor: String = "FFFFFFFF",
        canDragging: Bool = true,
        showBorder: Bool = true,
        showInputBorder: Bool = true,
        showReturnButton: Bool = true,
        typingEffect: Bool = true,
        themName: String = "",
        presentationStyle: String = "fullscreen",
        typeEndpoints: String = "MegamilChat",
        messages: [ChatMessage] = [],
        listSuggestions: Any = "",
        placeholder: String = L10n.enterAMessage,
        sendButtonIcon: String = "paperplane.fill",
        recordButtonIcon: String = "mic.fill",
        buttonColor: String = "#0000FF",
        listBorderColors: Any = "FFFFFFFF,FFFF00FF,FF0000FF",
        listInputBorderColors: Any = "008000FF,0000FFFF,FFA500FF",
        ref: String = "",
        name: String = "",
        contact: String = "",
        baseUrl: String = "",
        endpoint: String = "",
        bearerToken: String = "",
        allowAudioRecording: Bool = false,
        meBubbleColor: String = "0000FFFF",
        meBubbleTextColor: String = "FFFFFFFF",
        themBubbleColor: String = "008000FF",
        themBubbleTextColor: String = "FFFFFFFF"
    ) {
        self.backgroundColor = Color(hex: backgroundColor)
        self.canDragging = canDragging
        self.showBorder = showBorder
        self.showInputBorder = showInputBorder
        self.showReturnButton = showReturnButton
        self.typingEffect = typingEffect
        self.themName = themName
        self.presentationStyle = PresentationStyle.fromString(presentationStyle)
        self.typeEndpoints = TypeEndpoints.fromString(typeEndpoints)
        self.messages = messages
        
        if let suggestionsArray = listSuggestions as? [String] {
            self.listSuggestions = suggestionsArray
        } else if let suggestionsString = listSuggestions as? String {
            self.listSuggestions = suggestionsString.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        }
        
        self.placeholder = placeholder
        self.sendButtonIcon = sendButtonIcon
        self.recordButtonIcon = recordButtonIcon
        self.buttonColor = Color(hex: buttonColor)
        
        if let borderColorsArray = listBorderColors as? [String] {
            self.listBorderColors = borderColorsArray.map { Color(hex: $0) }
        } else if let borderColorsString = listBorderColors as? String {
            self.listBorderColors = borderColorsString.split(separator: ",").map { Color(hex: String($0)) }
        }
        
        if let inputBorderColorsArray = listInputBorderColors as? [String] {
            self.listInputBorderColors = inputBorderColorsArray.map { Color(hex: $0) }
        } else if let inputBorderColorsString = listInputBorderColors as? String {
            self.listInputBorderColors = inputBorderColorsString.split(separator: ",").map { Color(hex: String($0)) }
        }
        
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
    
}
