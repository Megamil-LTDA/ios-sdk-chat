//
//  typeEndpoints.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 05/11/24.
//
public enum TypeEndpoints: String, Codable {
    case OpenAI = "OpenAI"
    case MegamilChat = "MegamilChat"
    case CustomURL = "CustomURL"
    
    // Função para inicializar a partir de uma string
    static func fromString(_ endpointString: String) -> TypeEndpoints {
        switch endpointString.lowercased() {
            case "openai":
                return .OpenAI
            case "megamilchat":
                return .MegamilChat
            case "customurl":
                return .CustomURL
            default:
                return .MegamilChat
        }
    }
}
