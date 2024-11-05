//
//  MegamilChatViewModel.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    
    var ref: String = ""
    var name: String = ""
    var contact: String = ""
    
    var baseUrl: String = ""
    var endpoint: String = ""
    var bearerToken: String = ""
    var typeEndPoints: TypeEndPoints = .MegamilChat
    
    var allowedSHAFingerprints: [String] = []
    
    init(baseUrl: String = "", endpoint: String = "", ref: String = "", name: String = "", contact: String = "", bearerToken: String, typeEndPoints: TypeEndPoints, allowedSHAFingerprints: [String] = []) {
        
        self.bearerToken = bearerToken
        self.typeEndPoints = typeEndPoints
        self.ref = ref
        self.name = name
        self.contact = contact
        self.allowedSHAFingerprints = allowedSHAFingerprints
        
        switch(typeEndPoints) {
            case .OpenAI:
                self.baseUrl = "https://api.openai.com/v1"
                self.endpoint = "/chat/completions"
            case .MegamilChat:
                self.baseUrl = "https://rag.megamil.com.br/v1"
                self.endpoint = "/chat/completionLC"
            case .CustomURL:
                self.baseUrl = baseUrl
                self.endpoint = endpoint
                break
        }
        
    }
    
    func sendMessage(message: String, callBack:@escaping (Bool?, ChatMessage?) -> Void) {
        switch(typeEndPoints) {
            case .OpenAI:
                self.sendMessageOpenAi(message: message) { success, response in
                    return callBack(success, response)
                }
            case .MegamilChat:
                self.sendMessageMegamil(message: message) { success, response in
                    return callBack(success, response)
                }
            case .CustomURL: //@todo testar
                self.sendMessageCustom(message: message) { success, response in
                    return callBack(success, response)
                }
                break
        }
        
    }
    
    private func sendMessageOpenAi(message: String, callBack:@escaping (Bool?, ChatMessage?) -> Void) {
        
        let apiLayer = ApiLayer(URL_BASE: self.baseUrl, Bearer: self.bearerToken, allowedSHAFingerprints: allowedSHAFingerprints)
        let params: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": message]]
        ]
        guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        apiLayer.callApi(Method: .POST, endpoint: self.endpoint, postData: postData, query: nil, showLoading: false, completion: { result,_  in
            
            guard let result = result else {
                callBack(false,nil)
                return
            }
            do {
                let openAiResponse = try JSONDecoder().decode(OpenAIResponse.self, from: result)
                callBack(true, openAiResponse.getMessage())
            } catch {
                SafePrint.decodableError(error: error)
                callBack(false,nil)
            }
            
        })
        
    }
    
    private func sendMessageMegamil(message: String, callBack:@escaping (Bool?, ChatMessage?) -> Void) {
        let apiLayer = ApiLayer(URL_BASE: self.baseUrl, Bearer: self.bearerToken, allowedSHAFingerprints: allowedSHAFingerprints)
        let params: [String: Any] = [
            "ref": ref,
            "name": name,
            "contact": contact,
            "question":message,
            "history":[]
        ]
        guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        apiLayer.callApi(Method: .POST, endpoint: self.endpoint, postData: postData, query: nil, showLoading: false, completion: { result,_  in
            
            guard let result = result else {
                callBack(false,nil)
                return
            }
            do {
                let openAiResponse = try JSONDecoder().decode(MegamilResponse.self, from: result)
                callBack(true, openAiResponse.getMessage())
            } catch {
                SafePrint.decodableError(error: error)
                callBack(false,nil)
            }
            
        })
        
    }
    
    private func sendMessageCustom(message: String, callBack:@escaping (Bool?, ChatMessage?) -> Void) {
        let apiLayer = ApiLayer(URL_BASE: self.baseUrl, Bearer: self.bearerToken, allowedSHAFingerprints: allowedSHAFingerprints)
        let params: [String: Any] = [
            "ref": ref,
            "name": name,
            "contact": contact,
            "question":message,
            "history":[]
        ]
        guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        apiLayer.callApi(Method: .POST, endpoint: self.endpoint, postData: postData, query: nil, showLoading: false, completion: { result,_  in
            
            guard let result = result else {
                callBack(false,nil)
                return
            }
            do {
                let openAiResponse = try JSONDecoder().decode(MegamilResponse.self, from: result)
                callBack(true, openAiResponse.getMessage())
            } catch {
                SafePrint.decodableError(error: error)
                callBack(false,nil)
            }
            
        })
        
    }
    
}
