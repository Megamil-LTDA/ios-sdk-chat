//
//  SSLPinningManager.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation
import CryptoKit
import Security

class SSLPinningManager {
    let allowedSHAFingerprints: [String]
    
    init(allowedSHAFingerprints: [String]) {
        self.allowedSHAFingerprints = allowedSHAFingerprints
    }
    
    func validateCertificate(for trust: SecTrust) -> Bool {
        var error: CFError?
        if SecTrustEvaluateWithError(trust, &error) {
            guard let certificates = SecTrustCopyCertificateChain(trust) as? [SecCertificate],
                  let firstCertificate = certificates.first else {
                SafePrint("Erro ao obter a cadeia de certificados", type: .error)
                return false
            }
            let data = SecCertificateCopyData(firstCertificate) as Data
            let sha256Fingerprint = calculateSHA256FingerSafePrint(data: data)
            let isValid = allowedSHAFingerprints.contains(sha256Fingerprint)
            SafePrint("🔐 Certificado \(isValid ? "" : "Não ")é valido \n\(sha256Fingerprint)", type: isValid ? .default : .error)
            return isValid
        } else {
            if let error = error {
                SafePrint("Erro ao avaliar o certificado: \(error)", type: .error)
            }
            return false
        }
    }
    
    func calculateSHA256FingerSafePrint(data: Data) -> String {
        let sha256Data = data.withUnsafeBytes { bytes -> Data in
            let hash = SHA256.hash(data: data)
            return Data(hash)
        }
        
        let sha256Fingerprint = sha256Data.map { String(format: "%02hhx", $0) }.joined(separator: ":").uppercased()
        return sha256Fingerprint
    }
}
