//
//  DecodableUtil.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/12/24.
//
import Foundation

public enum DecodableUtil: Codable {
    case integer(Int)
    case double(Double)
    case string(String)
    case boolean(Bool)
    case emptyArray([Any])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
            //        if let x = try? decoder.singleValueContainer().decode([Any].self), x.isEmpty {
            //            self = .emptyArray(x)
            //        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Bool.self) {
            self = .boolean(x)
            return
        }
        throw DecodingError.typeMismatch(DecodableUtil.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DecodableNumber"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .integer(let x):
                try container.encode(x)
            case .double(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            case .boolean(let x):
                try container.encode(x)
            default:
                break
        }
    }
    
    public func stringValue() -> String {
        switch self {
            case .integer(let x):
                return "\(x)"
            case .double(let x):
                return "\(x)"
            case .string(let x):
                return x
            case .boolean(let x):
                return x ? "true" : "false"
            default:
                return ""
        }
    }
    
    public func intValue() -> Int? {
        switch self {
            case .integer(let x):
                return x
            case .double(let x):
                return Int(x)
            case .string(let x):
                return Int(x)
            case .boolean(let x):
                return x ? 1 : 0
            default:
                return -1
        }
    }
    
    public func doubleValue() -> Double? {
        switch self {
            case .integer(let x):
                return Double(x)
            case .double(let x):
                return x
            case .string(let x):
                return Double(x)
            case .boolean(let x):
                return x ? 1.0 : 0.0
            default:
                return -1.0
        }
    }
    
    public func floatValue() -> Float? {
        switch self {
            case .integer(let x):
                return Float(x)
            case .double(let x):
                return Float(x)
            case .string(let x):
                return Float(x)
            case .boolean(let x):
                return x ? 1.0 : 0.0
            default:
                return -1.0
        }
    }
    
    public func decimalValue() -> Decimal? {
        switch self {
            case .integer(let x):
                return Decimal(x)
            case .double(let x):
                return Decimal(x)
            case .string(let x):
                return Decimal(string: x)
            case .boolean(let x):
                return x ? 1 : 0
            default:
                return -1.0
        }
    }
    
    public func boolValue() -> Bool? {
        switch self {
            case .integer(let x):
                return x != 0
            case .double(let x):
                return x != 0.0
            case .string(let x):
                return x == "true"
            case .boolean(let x):
                return x
            default:
                return false
        }
    }
    
}
