//
//  JSONEncoderUtility.swift
//  
//
//  Created by Artemy Volkov on 05.09.2023.
//

import Foundation

public struct JSONEncoderUtility {
    public static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    public static func encode<T: Encodable>(_ value: T) throws -> String? {
        let jsonData = try encoder.encode(value)
        return String(data: jsonData, encoding: .utf8)
    }
}
