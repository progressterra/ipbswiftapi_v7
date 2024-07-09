//
//  RequestProtocol.swift
//
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

/// A protocol defining the requirements for a network request.
///
/// Types conforming to `Request` encapsulate all the necessary information to construct a network request, including the endpoint path, HTTP method, headers, and body. Conformers can optionally include query parameters and multipart/form-data for uploads.
///
/// ## Topics
///
/// ### Required Properties
///
/// - ``path``: The endpoint path for the request.
/// - ``method``: The HTTP method to be used for the request.
/// - ``token``: An optional bearer token for authorization.
/// - ``contentType``: The content type of the request body.
/// - ``accept``: The expected content type of the response.
/// - ``body``: The request body encoded from the `Parameters` type.
/// - ``headers``: Additional HTTP headers for the request.
/// - ``queryParameters``: The query parameters for the request.
/// - ``media``: An array of `MediaModel` for multipart/form-data uploads.
///
/// ### Creating Requests
///
/// - ``asURLRequest(baseURL:token:)``
///
public protocol Request {
    /// The type of parameters to be encoded into the request body.
    associatedtype Parameters: Encodable
    /// The type of parameters to be encoded into the query string of the request URL.
    associatedtype QueryParameters: Encodable
    /// The expected return type of the request, which must conform to `Codable` and `ResultContaining`.
    associatedtype ReturnType: Codable & ResultContaining
    
    /// The endpoint path of the request.
    var path: String { get }
    /// The HTTP method to be used for the request. Defaults to GET.
    var method: HTTPMethod { get }
    /// An optional bearer token for authorization. If not provided, the token, if needed, should be included in the headers.
    var token: String? { get }
    /// The content type of the request body. Defaults to `"application/json"`.
    var contentType: String? { get }
    /// The expected content type of the response. Defaults to `"text/plain"`.
    var accept: String? { get }
    /// The request body, encoded from the `Parameters` type.
    var body: Parameters? { get }
    /// Additional HTTP headers for the request.
    var headers: [String: String]? { get }
    /// The query parameters for the request, encoded from the `QueryParameters` type.
    var queryParameters: QueryParameters? { get }
    /// An array of `MediaModel` for multipart/form-data uploads. If provided, the request will be sent as multipart/form-data.
    var media: [MediaModel]? { get }
    
    /// Constructs a `URLRequest` configured with the properties of the conforming type.
    ///
    /// This method combines the base URL with the endpoint path, adds any specified query parameters, sets HTTP headers, and encodes the request body. For requests requiring multipart/form-data, it constructs the appropriate `httpBody`.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL of the API to which the request will be sent.
    ///   - token: An optional token to override the token provided by the `token` property.
    /// - Returns: A configured `URLRequest` ready for dispatch, or `nil` if the URL could not be constructed.
    func asURLRequest(baseURL: String, token: String?) -> URLRequest?
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
    
    func asURLRequest(baseURL: String, token: String? = nil) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        
        if let params = queryParameters {
            do {
                let jsonData = try JSONEncoderUtility.encoder.encode(params)
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    urlComponents.queryItems = json.map { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                }
            } catch {
                if IPBSettings.isLoggingEnabled {
                    print("Error encoding query parameters: \(error)")
                }
            }
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        /// If token is not set, use the one from the request
        let effectiveToken = token ?? self.token
        
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        if let accept {
            request.setValue(accept, forHTTPHeaderField: "Accept")
        }
        if let effectiveToken, !effectiveToken.isEmpty {
            request.setValue("Bearer \(effectiveToken)", forHTTPHeaderField: "Authorization")
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
