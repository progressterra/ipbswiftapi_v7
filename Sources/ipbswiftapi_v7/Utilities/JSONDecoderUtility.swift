//
//  JSONDecoderUtility.swift
//  
//
//  Created by Artemy Volkov on 05.09.2023.
//

import Foundation

public struct JSONDecoderUtility {
    public static let decoder = JSONDecoder()
    
    public static let customDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        let dateFormats = [
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss"
        ]
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone.gmt
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            for dateFormat in dateFormats {
                formatter.dateFormat = dateFormat
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string")
        }
        
        return decoder
    }()
    
    public static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
