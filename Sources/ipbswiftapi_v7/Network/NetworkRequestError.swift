//
//  NetworkRequestError.swift
//
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

/// Custom error type for network requests
public enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest(String)
    case badRequest(String)
    case unauthorized
    case forbidden(String)
    case notFound(String)
    case error4xx(_ code: Int)
    case serverError(String)
    case error5xx(_ code: Int)
    case decodingError(String)
    case urlSessionFailed(_ error: URLError)
    case unknownError(String)
    case customError(String)
    case timeoutError(String)
    case networkError(String)
    case sslError(String)
}
