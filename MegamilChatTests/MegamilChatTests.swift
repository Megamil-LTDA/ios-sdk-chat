//
//  MegamilChatTests.swift
//  MegamilChatTests
//
//  Created by Eduardo dos santos on 02/12/24.
//

import XCTest
import SwiftUI
@testable import MegamilChat

final class MegamilChatConfigTests: XCTestCase {
    
    func testMegamilChatConfigDecoding() {
        let data = """
        {
            "background_color": "#FFFFFF",
            "can_dragging": true,
            "show_border": true,
            "show_input_border": true,
            "show_return_button": false,
            "typing_effect": true,
            "them_name": "[Megamil Chat]",
            "presentation_style": "fullscreen",
            "type_endpoints": "MegamilChat",
            "messages": [
             {
                 "text": "Olá, sou o Megamil Chat! como posso ajudar?",
                 "timestamp": "05/11/2024 00:00",
                 "is_from_me": false
             }
            ],
            "list_suggestions": "🕢 Qual horário de funcionamento?,💲 Qual o valor da mensalidade?",
            "placeholder": "Digite uma mensagem...",
            "send_button_icon": "paperplane.fill",
            "record_button_icon": "mic.fill",
            "button_color": "#0000FF",
            "list_border_colors": "008000FF,0000FFFF,FF0000FF",
            "list_input_border_colors": "FFA500FF,FFC0CBFF,808080FF",
            "ref": "",
            "name": "",
            "contact": "",
            "base_url": "",
            "endpoint": "",
            "bearer_token": ".....",
            "allow_audio_recording": false,
            "me_bubble_color": "#0000FF",
            "me_bubble_text_color": "#FFFFFF",
            "them_bubble_color": "#008000",
            "them_bubble_text_color": "#FFFFFF"
        }
        """.data(using: .utf8)!
        
        let jsonDecoder = JSONDecoder()
        do {
            let config = try jsonDecoder.decode(MegamilChatConfig.self, from: data)
            
            XCTAssertEqual(config.themName, "[Megamil Chat]")
            XCTAssertEqual(config.placeholder, "Digite uma mensagem...")
            XCTAssertEqual(config.sendButtonIcon, "paperplane.fill")
            XCTAssertEqual(config.allowAudioRecording, false)
            XCTAssertEqual(config.listSuggestions, ["🕢 Qual horário de funcionamento?", "💲 Qual o valor da mensalidade?"])
            XCTAssertTrue(config.listBorderColors.contains(Color(hex: "008000FF")))
            XCTAssertTrue(config.listBorderColors.contains(Color(hex: "FF0000FF")))
            
            XCTAssertEqual(config.messages.count, 1)
            XCTAssertEqual(config.messages.first?.text, "Olá, sou o Megamil Chat! como posso ajudar?")
            XCTAssertEqual(config.messages.first?.isFromMe, false)
            
        } catch {
            XCTFail("Falha ao decodificar JSON: \(error)")
        }
    }
    
    func testMegamilChatConfigDecodingAlternativeCases() {
        let data = """
        {
            "background_color": "#FFFFFF",
            "can_dragging": true,
            "show_border": true,
            "show_input_border": true,
            "show_return_button": false,
            "typing_effect": true,
            "them_name": "[Megamil Chat]",
            "presentation_style": "fullscreen",
            "type_endpoints": "MegamilChat",
            "messages": [
             {
                 "text": "Olá, sou o Megamil Chat! como posso ajudar?",
                 "timestamp": "05/11/2024 00:00",
                 "isFromMe": true
             }
            ],
            "list_suggestions": ["🕢 Qual horário de funcionamento?","💲 Qual o valor da mensalidade?"],
            "placeholder": "Digite uma mensagem...",
            "send_button_icon": "paperplane.fill",
            "record_button_icon": "mic.fill",
            "button_color": "#0000FF",
            "list_border_colors": ["008000FF","0000FFFF","FF0000FF"],
            "list_input_border_colors": ["FFA500FF","FFC0CBFF","808080FF"],
            "ref": "",
            "name": "",
            "contact": "",
            "base_url": "",
            "endpoint": "",
            "bearer_token": ".....",
            "allow_audio_recording": false,
            "me_bubble_color": "#0000FF",
            "me_bubble_text_color": "#FFFFFF",
            "them_bubble_color": "#008000",
            "them_bubble_text_color": "#FFFFFF"
        }
        """.data(using: .utf8)!
        
        let jsonDecoder = JSONDecoder()
        do {
            let config = try jsonDecoder.decode(MegamilChatConfig.self, from: data)
            
            XCTAssertEqual(config.themName, "[Megamil Chat]")
            XCTAssertEqual(config.placeholder, "Digite uma mensagem...")
            XCTAssertEqual(config.sendButtonIcon, "paperplane.fill")
            XCTAssertEqual(config.allowAudioRecording, false)
            XCTAssertEqual(config.listSuggestions, ["🕢 Qual horário de funcionamento?", "💲 Qual o valor da mensalidade?"])
            XCTAssertTrue(config.listBorderColors.contains(Color(hex: "008000FF")))
            XCTAssertTrue(config.listBorderColors.contains(Color(hex: "FF0000FF")))
            
            XCTAssertEqual(config.messages.count, 1)
            XCTAssertEqual(config.messages.first?.text, "Olá, sou o Megamil Chat! como posso ajudar?")
            XCTAssertEqual(config.messages.first?.isFromMe, true)
            
        } catch {
            XCTFail("Falha ao decodificar JSON: \(error)")
        }
    }
    
}
