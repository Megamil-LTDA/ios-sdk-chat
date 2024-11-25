//
//  ApiLayer.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork

// enum HTTP types
public enum HTTP: String {
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
    case DELETE = "DELETE"
    case PATCH  = "PATCH"
}

public enum UP_TYPES: String {
    case TEXT   = "text"
    case FILE   = "file"
}

public class uploadApiObject {
    
    var name:   String?
    var file:   Data?
    var value:  String?
    var type:   UP_TYPES?
    
    init(name: String, file: Data? = nil, value: String? = nil, type: UP_TYPES) {
        self.name = name
        self.file = file
        self.value = value
        self.type = type
    }
    
}

open class ApiLayer {
    
    private let retry = 3
    private var numberTry = 1
    
    private var MockData: Data?
    private var Bearer: String?
    private var Basic: String?
    private var urlComponents: URLComponents?
    private var customHeader: [[String:String]] = []
    private var URL_BASE: String?
    private var delegate: URLSessionDelegate?
    private var disableSessionDelegate: Bool = false
    private var usingDefaultHeader: Bool = false
    
    /// Init ApiLayer
    /// Creates the object, to work with apis
    /// @param URL_BASE: optional, force a specific URL base,
    /// @param Bearer: optional, send Bearer token,
    /// /// @param Basic: optional, send Basic token,
    /// @param disableSessionDelegate: optional, Ignore Session Delegate.
    public init(URL_BASE: String?, Bearer: String? = nil, Basic: String? = nil , _ disableSessionDelegate: Bool = false, usingDefaultHeader: Bool = true, allowedSHAFingerprints: [String]) {
        
        self.URL_BASE = URL_BASE
        self.Bearer = Bearer
        self.Basic = Basic
        self.disableSessionDelegate = disableSessionDelegate
        self.usingDefaultHeader = usingDefaultHeader
        if(allowedSHAFingerprints.isEmpty) {
            self.disableSessionDelegate = true
        } else {
            self.delegate = SSLPinningDelegate(allowedSHAFingerprints: allowedSHAFingerprints)
        }
        
    }
    
    /// Custom header
    /// @Param customHeader: Required: define custom header
    public func customizeHeader(customHeader: [[String:String]]) {
        self.customHeader = customHeader
    }
    
    /// Inject JSON
    func injectJson(name: String, localJson: Bool = false) {
#if !PRODUCTION
        MockData = Data()
        if(localJson) {
            if let data = self.loadDataFromBundle(name: name, fileType: "json") {
                MockData = data
                SafePrint("Sucesso ao injetar JSON Local* (\(name).json)", showToast: true)
            } else {
                SafePrint("(\(name).json) Não encontrado", showToast: true)
            }
        } else {
            
            let urlString = "http://localhost:8080/server_swift/mock_api?json_name=\(name)"
            SafePrint("Call: (\(urlString))")
            guard let url = URL(string: urlString) else {
                SafePrint("(\(name)) Não encontrado", showToast: true)
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil { return }
                if let data = data {
                    self.MockData = data
                    SafePrint("Sucesso ao injetar JSON (\(name).json)", showToast: true)
                } else {
                    SafePrint("Falha ao consultar mock em \(urlString)", showToast: true)
                }
            }.resume()
            
        }
#endif
    }
    
    func loadDataFromBundle(name: String, fileType: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: fileType),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        return data
    }
    
    public func callApi(Method: HTTP,endpoint: String,postData: Data?, query: [URLQueryItem]?, showLoading: Bool = true, returnRawData: Bool = false, customLoadText: String = "Carregando...", uploadData: [uploadApiObject]? = nil, skipStatusValidation: Bool = true) async throws -> Data? {
        
        return try await withCheckedThrowingContinuation { continuation in
            self.callApi( Method:Method,endpoint:endpoint,postData:postData,query:query,showLoading:showLoading,returnRawData:returnRawData,customLoadText:customLoadText,uploadData:uploadData, skipStatusValidation:skipStatusValidation, completion: { result,error  in
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result)
                }
                
            })
        }
        
    }
    
    
    // Call API and return data
    /// @param Method: Required, define method http (Get,Post,Put,Delete)
    /// @param endpoint: Required, define endpoint, path etc from URL (path/endpoint)
    /// @param postData: Optional, send params on Body
    /// @param query: Optional, send URL query param Default true
    /// @param showLoading: Optional, show loading, Default true
    /// @param returnRawData: Return response API raw, Default false
    /// @param customLoadText: Custom Text on loading
    /// @param uploadData[]: Fites  to Upload
    /// @Function completion: Required, returns a function, passing the data and errors that were received
    public func callApi(Method: HTTP,endpoint: String,postData: Data?, query: [URLQueryItem]?, showLoading: Bool = true, returnRawData: Bool = false, customLoadText: String = "Carregando...", uploadData: [uploadApiObject]? = nil, skipStatusValidation: Bool = false, completion: @escaping (Data?,Error?) -> Void) {
#if !PRODUCTION
        if(MockData != nil) {
            sleep(1)
            completion(MockData, nil)
            return
        }
#endif
        
        self.preValidations(forceSkip: skipStatusValidation) { status, message in
            if(!status) {
                let error = NSError(domain: "Falha ao validar", code: 1, userInfo: ["response": message ?? ""])
                completion(nil,error)
                return
            }
            
            if(!UIDevice.isConnected()) {
                let error = NSError(domain:"", code:500, userInfo:[
                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Erro de conexão", comment: "") ,
                    NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "Parece que estamos com problemas de conexão.", comment: "")
                ])
                
                SafePrint(error.localizedDescription)
                completion(nil,error)
                return
            }
            
//            if(showLoading) { UIViewLoadding.progressBarDisplayer(msg: customLoadText, true) } //@todo
            
            DispatchQueue.main.async { [self] in
                
                self.urlComponents = URLComponents(url: URL(string: self.URL_BASE!)!, resolvingAgainstBaseURL: false)
                
                if (query != nil) {
                    self.urlComponents!.queryItems = query
                }
                
                self.urlComponents!.path = "\(self.urlComponents!.path)\(endpoint)"
                var request: URLRequest = URLRequest(url: self.urlComponents!.url!,timeoutInterval: Double.infinity)
                
                request.httpMethod = Method.rawValue
                
                var versionText = ""
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    versionText = "\(version)"
                    if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        versionText += "-\(build)"
                    }
                }
                
                var defaultHeader = [
                    "Content-Type" : "application/json",
                    "IOS": versionText
                ]
                
                //todo: Verificar custom header adiciona somente 1 key
                for cHeader in self.customHeader {
                    request.setValue("\(cHeader.first?.value ?? "")", forHTTPHeaderField: "\(cHeader.first?.key ?? "")")
                    defaultHeader.removeValue(forKey: "\(cHeader.first?.key ?? "")")
                }
                
                if(self.usingDefaultHeader) {
                    for dHeader in defaultHeader {
                        request.setValue("\(dHeader.value)", forHTTPHeaderField: "\(dHeader.key)")
                    }
                }
            
                if(self.Bearer != nil) { request.addValue("Bearer \(self.Bearer!)", forHTTPHeaderField: "Authorization") }
                if(self.Basic != nil) { request.addValue("Basic \(self.Basic!)", forHTTPHeaderField: "Authorization") }
                
                if(postData != nil) {
                    
                    request.httpBody = postData
                    
                } else if(uploadData != nil) {
                    
                    /// Prepare Upload Files
                    let boundary = "Boundary-\(UUID().uuidString)"
                    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    
                    var data = Data()
                    
                    for param in uploadData ?? [] {
                        
                        let paramName = param.name!
                        let paramType = param.type
                        
                        if paramType == .TEXT {
                            let paramValue = param.value!
                            
                            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                            data.append("Content-Disposition: form-data; name=\"\(paramName)\"\r\n\r\n".data(using: .utf8)!)
                            data.append("\(paramValue)".data(using: .utf8)!)
                            
                        } else if paramType == .FILE && param.file != nil {
                            
                            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"send_\(DateHelper.formatCurrentDateTime().replacingOccurrences(of: " ", with: "_")).png\"\r\n".data(using: .utf8)!)
                            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                            data.append(param.file!)
                            
                        }
                        
                        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
                        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
                        
                    }
                    
                    // let postData = String(data: data, encoding: .utf8)!
                    request.httpBody = data
                    SafePrint(data)
                    
                }
                
                SafePrint("******** CURL REQUEST ********")
                SafePrint("\(request.curlString())")
                SafePrint("******** CURL REQUEST ********")
                
                let session = URLSession(configuration: .ephemeral, delegate: !self.disableSessionDelegate ? delegate : nil, delegateQueue: nil)
                let task = session.dataTask(with: request) { data, response, error in
                    
                    let endpointSplit = endpoint.split(separator: "/")
                    var tempEndpoint = ""
                    for (index, value) in endpointSplit.enumerated() {
                        if(index < 2) { tempEndpoint += "/\(value)" }
                    }
                    
                    let responseHttp = response as? HTTPURLResponse
                    
                    if let statusCode = responseHttp?.statusCode {
                        if (statusCode == 401 || statusCode == 403) && !skipStatusValidation {
                            //@todo
                        }
                    }
                    
                    if(returnRawData) {
//                        UIViewLoadding.removeProgressBarDisplay() //@todo
                        completion(data,error)
                        return
                    } else {
                        SafePrint("******** RAW DATA \(tempEndpoint) ********")
                        SafePrint(String(data: data ?? Data(), encoding: .utf8) as Any)
                        SafePrint("******** RAW DATA ********")
                    }
                    
                    let error = NSError(domain: "API | \(tempEndpoint) | não respondeu", code: 1, userInfo: [
                        "curl": request.curlString(returnBody: true),
                        "response": data.self as Any
                    ])
                    
                    guard let data = data else {
                        
                        SafePrint(error.userInfo)
                        if(showLoading) {
                            DispatchQueue.main.async {
//                                UIViewLoadding.removeProgressBarDisplay() @todo
                                completion(nil,error)
                            }
                        } else {
                            completion(nil,error)
                        }
                        
                        return
                    }
                    
                    guard let dataString = String(data: data, encoding: .utf8) else {
                        SafePrint(error.userInfo)
                        return
                    }
                    
                    SafePrint("******** RESPONSE API \(tempEndpoint) ********")
                    SafePrint(dataString)
                    SafePrint("******** RESPONSE API \(tempEndpoint) ********")
                    
                    if(showLoading) {
                        DispatchQueue.main.async {
//                            UIViewLoadding.removeProgressBarDisplay() //@todo
                            completion(data,error)
                        }
                    } else {
                        completion(data,nil)
                    }
                    
                }
                
                task.resume()
                
            }
        }
    }
    
    func preValidations(forceSkip: Bool, completion: @escaping (Bool, String?) -> Void) {
        //@todo
        completion(true,nil)
    }
    
}
