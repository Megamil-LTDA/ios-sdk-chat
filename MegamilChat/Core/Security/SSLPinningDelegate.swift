//
//  SSLPinningDelegate.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation
import Security

class SSLPinningDelegate: NSObject, URLSessionDelegate {
    let sslPinningManager: SSLPinningManager
    
    init(allowedSHAFingerprints: [String]) {
        SafePrint("Using SSLPinningDelegate", prefix: "URLSessionDelegate")
        self.sslPinningManager = SSLPinningManager(allowedSHAFingerprints: allowedSHAFingerprints)
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            if sslPinningManager.validateCertificate(for: serverTrust) {
                let credential = URLCredential(trust: serverTrust)
                return (.useCredential, credential)
            } else {
                return (.cancelAuthenticationChallenge, nil)
            }
        } else {
            return (.performDefaultHandling, nil)
        }
    }
    
}
