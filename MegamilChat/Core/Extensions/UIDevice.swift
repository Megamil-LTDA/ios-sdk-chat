//
//  UIDevice.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork
import Network
import CoreNFC

// MARK: UIDevice
public extension UIDevice {
    
    static func isNFCAvailable() -> Bool {
        return NFCNDEFReaderSession.readingAvailable
    }
    
    // periphery:ignore
    struct VpnChecker {
        
        //        private static let vpnProtocolsKeysIdentifiers = [
        //            "tap", "tun", "ppp", "ipsec", "utun"
        //        ]
    
        //        static func isVpnActive() -> Bool {
        //            #if targetEnvironment(simulator)
        //                return true
        //            #else
        //                let cfDict = CFNetworkCopySystemProxySettings()
        //                if(cfDict == nil) {return false}
        //                let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        //                guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
        //                      let allKeys = keys.allKeys as? [String] else { return false }
        //
        //                    // Checking for tunneling protocols in the keys
        //                for key in allKeys {
        //                    for protocolId in vpnProtocolsKeysIdentifiers
        //                    where key.starts(with: protocolId) {
        //                        return true
        //                    }
        //                }
        //                return false
        //            #endif
        //        }
        
        static func isVpnActive(url: String, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: url) else {
                completion(false)
                return
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 2.0
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    SafePrint("Status da API:: \(httpResponse)")
                    if (200...299).contains(httpResponse.statusCode) || httpResponse.statusCode == 401 {
                        SafePrint("Ping bem-sucedido: \(httpResponse.statusCode)")
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        SafePrint("Resposta inesperada: \(httpResponse.statusCode)")
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                } else if let error = error {
                    SafePrint("Erro ao fazer o ping: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                } else {
                    SafePrint("Timeout ou resposta inválida")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    /*
     ------------------------------------
     Show device name
     ------------------------------------
     */
    static let getModelName: String? = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
            // @Update to iPhone 12 19/02
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
#if os(iOS)
            switch identifier {
                case "iPod5,1":                                 return "iPod touch (5th generation)"
                case "iPod7,1":                                 return "iPod touch (6th generation)"
                case "iPod9,1":                                 return "iPod touch (7th generation)"
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
                case "iPhone4,1":                               return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
                case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
                case "iPhone7,2":                               return "iPhone 6"
                case "iPhone7,1":                               return "iPhone 6 Plus"
                case "iPhone8,1":                               return "iPhone 6s"
                case "iPhone8,2":                               return "iPhone 6s Plus"
                case "iPhone8,4":                               return "iPhone SE"
                case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
                case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
                case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
                case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6":                return "iPhone X"
                case "iPhone11,2":                              return "iPhone XS"
                case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
                case "iPhone11,8":                              return "iPhone XR"
                case "iPhone12,1":                              return "iPhone 11"
                case "iPhone12,3":                              return "iPhone 11 Pro"
                case "iPhone12,5":                              return "iPhone 11 Pro Max"
                case "iPhone12,8":                              return "iPhone SE (2nd generation)"
                case "iPhone13,1":                              return "iPhone 12 mini"
                case "iPhone13,2":                              return "iPhone 12"
                case "iPhone13,3":                              return "iPhone 12 Pro"
                case "iPhone13,4":                              return "iPhone 12 Pro Max"
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
                case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
                case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
                case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
                case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
                case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
                case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
                case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
                case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
                case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
                case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
                case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
                case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
                case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
                case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
                case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
                case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
                case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
                case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
                case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
                case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
                case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
                case "AppleTV5,3":                              return "Apple TV"
                case "AppleTV6,2":                              return "Apple TV 4K"
                case "AudioAccessory1,1":                       return "HomePod"
                case "AudioAccessory5,1":                       return "HomePod mini"
                case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default:                                        return identifier
            }
#elseif os(tvOS)
            switch identifier {
                case "AppleTV5,3": return "Apple TV 4"
                case "AppleTV6,2": return "Apple TV 4K"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
                default: return identifier
            }
#endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
    /*
     ------------------------------------
     Validate if there is an internet connection
     ------------------------------------
     */
    static func isConnected() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        var isConnected = false
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                isConnected = true
            } else {
                isConnected = false
            }
        }
        
        monitor.start(queue: queue)
        
            // Espera um pouco para garantir que o monitor tenha tempo de atualizar o status
        sleep(1)
        
        monitor.cancel()
        return isConnected
    }
    
        // Returns the name of the wifi network
        // periphery:ignore
    static let getWifiName: String = {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid ?? ""
    }()
    
    /*
     ------------------------------------
     Get data about available storage
     ------------------------------------
     */
        // periphery:ignore
    static let getAvailableStorage: Int64? = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!) {
            if let freeSize = dictionary[FileAttributeKey.systemFreeSize] as? NSNumber {
                return freeSize.int64Value
            }
        } else {
            SafePrint("Failed to get data about available storage")
            return -1
        }
        return nil
    }()
    
    /*
     ------------------------------------
     Get data about storage
     ------------------------------------
     */
        // periphery:ignore
    static let getTotalStorage: Int64? = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!) {
            if let freeSize = dictionary[FileAttributeKey.systemSize] as? NSNumber {
                return freeSize.int64Value
            }
        } else {
            SafePrint("Failed to get data about storage")
            return -1
        }
        return nil
    }()
    
    enum DeviceModel {
        case iPhone5_iPhone5S_iPhone5C
        case iPhone6_iPhone6S_iPhone7_iPhone8
        case iPhone6Plus_iPhone6SPlus_iPhone7Plus_iPhone8Plus
        case iPhoneX_iPhoneXS
        case iPhoneXR
        case iPhoneXSMax
    }
    
    var modelByResolution: DeviceModel? {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return .iPhone5_iPhone5S_iPhone5C
                case 1334:
                    return .iPhone6_iPhone6S_iPhone7_iPhone8
                case 1920, 2208:
                    return .iPhone6Plus_iPhone6SPlus_iPhone7Plus_iPhone8Plus
                case 2436:
                    return .iPhoneX_iPhoneXS
                case 2688:
                    return .iPhoneXR
                case 1792:
                    return .iPhoneXSMax
                default:
                    return nil
            }
        }
        return nil
    }
    
    var hasNotch: Bool {
        if self.modelByResolution == .iPhoneX_iPhoneXS
            || self.modelByResolution == .iPhoneXR
            || self.modelByResolution == .iPhoneXSMax {
            return true
        }
        return false
    }
    
    static var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    static let modelName: String = {
        func mapToDevice(identifier: String) -> String {
#if os(iOS)
            switch identifier {
                case "iPod5,1":                                 return "iPod touch (5th generation)"
                case "iPod7,1":                                 return "iPod touch (6th generation)"
                case "iPod9,1":                                 return "iPod touch (7th generation)"
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
                case "iPhone4,1":                               return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
                case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
                case "iPhone7,2":                               return "iPhone 6"
                case "iPhone7,1":                               return "iPhone 6 Plus"
                case "iPhone8,1":                               return "iPhone 6s"
                case "iPhone8,2":                               return "iPhone 6s Plus"
                case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
                case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
                case "iPhone8,4":                               return "iPhone SE"
                case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
                case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6":                return "iPhone X"
                case "iPhone11,2":                              return "iPhone XS"
                case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
                case "iPhone11,8":                              return "iPhone XR"
                case "iPhone12,1":                              return "iPhone 11"
                case "iPhone12,3":                              return "iPhone 11 Pro"
                case "iPhone12,5":                              return "iPhone 11 Pro Max"
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
                case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
                case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
                case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
                case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
                case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
                case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
                case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
                case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
                case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
                case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
                case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
                case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
                case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
                case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
                case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
                case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
                case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
                case "AppleTV5,3":                              return "Apple TV"
                case "AppleTV6,2":                              return "Apple TV 4K"
                case "AudioAccessory1,1":                       return "HomePod"
                case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default:                                        return identifier
            }
#elseif os(tvOS)
            switch identifier {
                case "AppleTV5,3": return "Apple TV 4"
                case "AppleTV6,2": return "Apple TV 4K"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
                default: return identifier
            }
#endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
} // end - UIDevice
