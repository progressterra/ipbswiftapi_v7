//
//  JSONDecoderUtility.swift
//
//
//  Created by Artemy Volkov on 05.09.2023.
//

import Foundation

/// Provides utilities for JSON decoding, including a custom date decoder.
///
/// `JSONDecoderUtility` simplifies the process of decoding JSON data into Swift model objects. It includes a custom date decoder to handle multiple date formats seamlessly within a single decoder instance. This is particularly useful for APIs that may return dates in different formats.
///
/// ## Topics
///
/// ### Custom Date Decoder
///
/// - ``customDateDecoder``
///
/// ### Decoding JSON
///
/// - ``decode(_:from:)``
///
public struct JSONDecoderUtility {
    
    /// A default `JSONDecoder` instance for general use.
    public static let decoder = JSONDecoder()
    
    /// A `JSONDecoder` configured with a custom date decoding strategy.
    ///
    /// This decoder is capable of parsing date strings in multiple formats, making it robust against varying date formats that may be encountered in JSON data. The supported formats include:
    ///
    /// - "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    /// - "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    /// - "yyyy-MM-dd'T'HH:mm:ssZ"
    /// - "yyyy-MM-dd'T'HH:mm:ss"
    ///
    /// The custom decoding strategy attempts to parse the date string using each format in order. If none of the formats match, it throws a `DecodingError.dataCorruptedError`, indicating that the date string could not be decoded.
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
            formatter.timeZone = TimeZone.current
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
    
    /// Decodes a JSON object into a specified `Decodable` type.
    ///
    /// - Parameters:
    ///   - type: The type of the model to decode into.
    ///   - data: The JSON data to decode.
    /// - Returns: An instance of the specified type.
    /// - Throws: An error if the data could not be decoded into the specified type.
    ///
    /// This method uses the default `decoder` instance. For JSON data containing dates in the supported formats, use `customDateDecoder` to take advantage of the custom date decoding strategy.
    public static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
