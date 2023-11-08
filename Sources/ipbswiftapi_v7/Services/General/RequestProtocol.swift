//
//  RequestProtocol.swift
//  
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

/// Request Protocol
public protocol Request {
    associatedtype Parameters: Encodable
    associatedtype QueryParameters: Encodable
    associatedtype ReturnType: Codable & ResultContaining
    
    var path: String { get }
    var method: HTTPMethod { get }
    var token: String? { get }
    var contentType: String? { get }
    var accept: String? { get }
    var body: Parameters? { get }
    var headers: [String: String]? { get }
    var queryParameters: QueryParameters? { get }
    /// Set if you need to perform multipart/form-data request
    var media: [MediaModel]? { get }
}

public extension Request {
    // Defaults
    var method: HTTPMethod { .get }
    var contentType: String? { "application/json" }
    var accept: String? { "text/plain"}
    var token: String? { nil }
    var body: Parameters? { nil }
    var headers: [String: String]? { nil }
    var queryParameters: QueryParameters? { nil }
    var media: [MediaModel]? { nil }
    
    /// Transforms an Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        
        if let params = queryParameters {
            var queryItems: [URLQueryItem] = []
            let mirror = Mirror(reflecting: params)
            for child in mirror.children {
                if let label = child.label, let value = child.value as? CustomStringConvertible {
                    queryItems.append(URLQueryItem(name: label, value: value.description))
                }
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        if let accept {
            request.setValue(accept, forHTTPHeaderField: "Accept")
        }
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let media {
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createMultipartDataBody(media: media, boundary: boundary)
        } else {
            if let contentType {
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
            if let body = body, let httpBody = try? JSONEncoderUtility.encoder.encode(body) {
                request.httpBody = httpBody
            }
        }
        
        return request
    }
    
    private func createMultipartDataBody(media: [MediaModel]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let media {
            for mediaObject in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(mediaObject.key)\"; filename=\"\(UUID())\(mediaObject.fileExtension)\"\(lineBreak)")
                body.append("Content-Type: \(mediaObject.mimeType + lineBreak + lineBreak)")
                body.append(mediaObject.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}
