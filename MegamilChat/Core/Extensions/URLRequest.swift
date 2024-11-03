//
//  URLRequest.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation

extension URLRequest {
    
    /**
     Returns a cURL command representation of this URL request.
     */
    func curlString(returnBody: Bool = true) -> String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value.replacingOccurrences(of: "CHAVE A SER OCULTADA", with: "{{PLACEHOLDER}}"))'")
            }
        }
        
        if let data = httpBody, let body = String(data: data, encoding: .utf8), returnBody {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
}
