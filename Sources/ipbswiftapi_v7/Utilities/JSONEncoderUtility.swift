//
//  JSONEncoderUtility.swift
//
//
//  Created by Artemy Volkov on 05.09.2023.
//

import Foundation

/// A utility for encoding objects into JSON strings.
///
/// `JSONEncoderUtility` provides a centralized `JSONEncoder` instance with a preconfigured date encoding strategy. This utility simplifies the conversion of `Encodable` objects into JSON format, especially for types that include `Date` fields, ensuring they are encoded in ISO 8601 format.
///
/// ## Usage
///
/// Use the `encode(_:)` function to convert any `Encodable` object into a JSON string, ready for transmission over the network or saving locally. This function wraps the encoding process and automatically handles the conversion of the resulting data into a UTF-8 string.
///
/// ```swift
/// struct MyModel: Codable {
///     let id: Int
///     let date: Date
/// }
///
/// let model = MyModel(id: 1, date: Date())
/// if let jsonString = try? JSONEncoderUtility.encode(model) {
///     print(jsonString)
/// }
/// ```
///
/// ## Topics
///
/// ### JSON Encoding
///
/// - ``encode(_:)``
///
public struct JSONEncoderUtility {
    
    /// A preconfigured `JSONEncoder` instance that uses the `.iso8601` date encoding strategy.
    ///
    /// This encoder is ideal for encoding objects that contain `Date` fields, ensuring that dates are represented in a standardized format across your JSON data.
    public static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    /// Encodes an `Encodable` object into a JSON string.
    ///
    /// - Parameter value: The `Encodable` object to be encoded into JSON.
    /// - Returns: A `String?` containing the JSON representation of the object, or `nil` if encoding fails.
    /// - Throws: An error if the object could not be encoded.
    ///
    /// This method utilizes the preconfigured `encoder` to encode the object. It then attempts to convert the resulting JSON data into a UTF-8 string representation.
    public static func encode<T: Encodable>(_ value: T) throws -> String? {
        let jsonData = try encoder.encode(value)
        return String(data: jsonData, encoding: .utf8)
    }
}
