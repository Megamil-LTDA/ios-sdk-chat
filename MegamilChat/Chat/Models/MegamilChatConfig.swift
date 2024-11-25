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
    public var themName: String = ""
    public var presentationStyle: PresentationStyle = .fullscreen
    public var typeEndpoints: TypeEndpoints = .MegamilChat
    public var messages: [ChatMessage] = []
    public var listSuggestions: [String]? // Permite que seja nulo
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
        themName = try container.decodeIfPresent(String.self, forKey: .themName) ?? ""
        presentationStyle = PresentationStyle.fromString(try container.decodeIfPresent(String.self, forKey: .presentationStyle) ?? "fullscreen")
        typeEndpoints = TypeEndpoints.fromString(try container.decodeIfPresent(String.self, forKey: .typeEndpoints) ?? "MegamilChat")
        messages = try container.decodeIfPresent([ChatMessage].self, forKey: .messages) ?? []
        if let suggestionsString = try container.decodeIfPresent(String.self, forKey: .listSuggestions) {
            listSuggestions = suggestionsString.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        }
        placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder) ?? L10n.enterAMessage
        sendButtonIcon = try container.decodeIfPresent(String.self, forKey: .sendButtonIcon) ?? "paperplane.fill"
        recordButtonIcon = try container.decodeIfPresent(String.self, forKey: .recordButtonIcon) ?? "mic.fill"
        buttonColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .buttonColor) ?? "#0000FF")
        listBorderColors = (try container.decodeIfPresent(String.self, forKey: .listBorderColors)?.split(separator: ",").map { Color(hex: String($0)) }) ?? []
        listInputBorderColors = (try container.decodeIfPresent(String.self, forKey: .listInputBorderColors)?.split(separator: ",").map { Color(hex: String($0)) }) ?? []
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
        themName: String = "",
        presentationStyle: String = "fullscreen",
        typeEndpoints: String = "MegamilChat",
        messages: [ChatMessage] = [],
        listSuggestions: String = "",
        placeholder: String = L10n.enterAMessage,
        sendButtonIcon: String = "paperplane.fill",
        recordButtonIcon: String = "mic.fill",
        buttonColor: String = "#0000FF",
        listBorderColors: String = "FFFFFFFF,FFFF00FF,FF0000FF",
        listInputBorderColors: String = "008000FF,0000FFFF,FFA500FF",
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
        self.themName = themName
        self.presentationStyle = PresentationStyle.fromString(presentationStyle)
        self.typeEndpoints = TypeEndpoints.fromString(typeEndpoints)
        self.messages = messages
        self.listSuggestions = listSuggestions.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        self.placeholder = placeholder
        self.sendButtonIcon = sendButtonIcon
        self.recordButtonIcon = recordButtonIcon
        self.buttonColor = Color(hex: buttonColor)
        self.listBorderColors = listBorderColors.split(separator: ",").map { Color(hex: String($0)) }
        self.listInputBorderColors = listInputBorderColors.split(separator: ",").map { Color(hex: String($0)) }
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

    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        backgroundColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .backgroundColor) ?? "#FFFFFF")
//        canDragging = try container.decodeIfPresent(Bool.self, forKey: .canDragging) ?? true
//        showBorder = try container.decodeIfPresent(Bool.self, forKey: .showBorder) ?? true
//        showInputBorder = try container.decodeIfPresent(Bool.self, forKey: .showInputBorder) ?? true
//        showReturnButton = try container.decodeIfPresent(Bool.self, forKey: .showReturnButton) ?? true
//        themName = try container.decodeIfPresent(String.self, forKey: .themName) ?? ""
//        presentationStyle = PresentationStyle.fromString(try container.decodeIfPresent(String.self, forKey: .presentationStyle) ?? "fullscreen")
//        typeEndpoints = TypeEndpoints.fromString(try container.decodeIfPresent(String.self, forKey: .typeEndpoints) ?? "typeEndPoints")
//        messages = try container.decodeIfPresent([ChatMessage].self, forKey: .messages) ?? []
//        suggestions = try container.decodeIfPresent([String].self, forKey: .suggestions) ?? []
//        placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder) ?? L10n.enterAMessage
//        sendButtonIcon = try container.decodeIfPresent(String.self, forKey: .sendButtonIcon) ?? "paperplane.fill"
//        recordButtonIcon = try container.decodeIfPresent(String.self, forKey: .recordButtonIcon) ?? "mic.fill"
//        buttonColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .buttonColor) ?? "#0000FF")
//        listBorderColors = (try container.decodeIfPresent([String].self, forKey: .listBorderColors) ?? ["#008000", "#0000FF", "#FF0000"]).map { Color(hex: $0) }
//        listInputBorderColors = (try container.decodeIfPresent([String].self, forKey: .listInputBorderColors) ?? ["#FFA500", "#FFC0CB", "#808080"]).map { Color(hex: $0) }
//        ref = try container.decodeIfPresent(String.self, forKey: .ref) ?? ""
//        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
//        contact = try container.decodeIfPresent(String.self, forKey: .contact) ?? ""
//        baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl) ?? ""
//        endpoint = try container.decodeIfPresent(String.self, forKey: .endpoint) ?? ""
//        bearerToken = try container.decodeIfPresent(String.self, forKey: .bearerToken) ?? ""
//        allowAudioRecording = try container.decodeIfPresent(Bool.self, forKey: .allowAudioRecording) ?? false
//        meBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleColor) ?? "#0000FF")
//        meBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .meBubbleTextColor) ?? "#FFFFFF")
//        themBubbleColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleColor) ?? "#008000")
//        themBubbleTextColor = Color(hex: try container.decodeIfPresent(String.self, forKey: .themBubbleTextColor) ?? "#FFFFFF")
//    }


/* Exemplo do json da request
 {
     "backgroundColor": "#FFFFFF",
     "canDragging": true,
     "showBorder": true,
     "showInputBorder": true,
     "showReturnButton": false,
     "themName": "[Megamil Chat]",
     "presentationStyle": "fullscreen",
     "typeEndpoints": "MegamilChat",
     "messages": [
         {
         "text": "Olá, sou o Megamil Chat! como posso ajudar?",
         "timestamp": "05/11/2024 00:00",
         "isFromMe": false
         }
     ],
     "suggestions": "Sugestão 1...|Sugestão 2...",
     "placeholder": "Digite uma mensagem...",
     "sendButtonIcon": "paperplane.fill",
     "recordButtonIcon": "mic.fill",
     "buttonColor": "#0000FF",
     "borderColor": "008000FF,0000FFFF,FF0000FF",
     "borderInputColor": "FFA500FF,FFC0CBFF",808080FF",
     "ref": "",
     "name": "",
     "contact": "",
     "baseUrl": "",
     "endpoint": "",
     "bearerToken": "0564f2ba7db311ef8c940242ac130004",
     "allowAudioRecording": false,
     "meBubbleColor": "#0000FF",
     "meBubbleTextColor": "#FFFFFF",
     "themBubbleColor": "#008000",
     "themBubbleTextColor": "#FFFFFF"
 }
 */

/* Exemplo do json da request base
 {
     "background_color": "FFFFFFFF",
     "show_border": true,
     "show_input_border": true,
     "them_name": "[Megamil AI]",
     "placeholder": "Digite uma mensagem...",
     "send_button_icon": "paperplane.fill",
     "record_button_icon": "mic.fill",
     "button_color": "0000FFFF",
     "allow_audio_recording": false,
     "me_bubble_color": "0000FFFF",
     "me_bubble_text_color": "FFFFFFFF",
     "them_bubble_color": "008000FF",
     "them_bubble_text_color": "FFFFFFFF",
     "list_suggestions": "Olá,Como posso ajudar?,Fale mais",
     "messages": [
         {
            "text": "Olá, sou o Megamil Chat! como posso ajudar?",
            "timestamp": "05/11/2024 00:00",
            "isFromMe": false
         }
     ],
     "list_border_colors": "FF5733FF,FFC300FF,DAF7A6FF",
     "list_input_border_colors": "C70039FF,900C3FFF,581845FF",
     "bearer_token": "0564f2ba7db311ef8c940242ac130004"
 }
 */
