//
//  NetworkDispatcher.swift
//
//
//  Created by Artemy Volkov on 08.07.2023.
//

import Combine
import Foundation

/// A struct responsible for managing network requests.
///
/// `NetworkDispatcher` provides an interface to dispatch network requests and handle responses in a type-safe manner. It leverages `Combine` for asynchronous operations and provides utilities for decoding the response data into Swift types. This class supports logging of requests and responses if enabled through ``IPBSettings``.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init(urlSession:jsonDecoder:)``
///
/// ### Request Dispatching
///
/// - ``dispatch(request:)``
/// - ``dispatchRawData(request:)``
///
public struct NetworkDispatcher {
    /// The URLSession used for network requests.
    let urlSession: URLSession
    /// The JSONDecoder used to decode the response data.
    let jsonDecoder: JSONDecoder
    
    /// Initializes a new network dispatcher with optional custom configurations.
    /// - Parameters:
    ///   - urlSession: The URLSession to use for dispatching network requests. Defaults to `.shared`.
    ///   - jsonDecoder: The JSONDecoder to use when decoding responses. Defaults to `JSONDecoderUtility.customDateDecoder`.
    public init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoderUtility.customDateDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    /// Dispatches a URLRequest and returns a publisher emitting the decoded response or an error.
    ///
    /// This method performs a network request using the provided `URLRequest` and attempts to decode the response into the specified `ReturnType`.
    /// If the request fails or decoding fails, it emits a `NetworkRequestError`.
    ///
    /// - Parameter request: The `URLRequest` to be dispatched.
    /// - Returns: A publisher emitting the decoded data on success or an error on failure.
    public func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                
                if IPBSettings.isLoggingEnabled {
                    print("Response: " + response.debugDescription)
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON string:\n\(jsonString)")
                    }
                }
                
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                return data
            }
            .decode(type: ReturnType.self, decoder: jsonDecoder)
            .mapError { error in
                if IPBSettings.isLoggingEnabled {
                    print("Error: \(error)")
                }
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    /// Dispatches a URLRequest and returns a publisher emitting the raw data of the response or an error.
    ///
    /// This method is similar to `dispatch(request:)` but it does not attempt to decode the response, returning the raw data instead.
    /// - Parameter request: The `URLRequest` to be dispatched.
    /// - Returns: A publisher emitting raw data on success or an error on failure.
    public func dispatchRawData(request: URLRequest) -> AnyPublisher<Data, NetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                if IPBSettings.isLoggingEnabled {
                    print("Response: " + response.debugDescription)
                    print("Received Data Size: \(data.count) bytes")
                }
                
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                
                return data
            }
            .mapError { error in
                if IPBSettings.isLoggingEnabled {
                    print("Error: \(error)")
                }
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private Methods
private extension NetworkDispatcher {
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest("Ошибка запроса")
        case 401: return .unauthorized
        case 403: return .forbidden("Доступ заперещен")
        case 404: return .notFound("Не найдено")
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError("Ошибка сервера")
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError("Непредвиденная ошибка")
        }
    }
    
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            switch urlError.code {
            case .timedOut:
                return .timeoutError("Time out error")
            case .cannotConnectToHost, .networkConnectionLost:
                return .networkError("Network connection error")
            case .secureConnectionFailed, .serverCertificateHasBadDate, .serverCertificateUntrusted, .serverCertificateHasUnknownRoot, .serverCertificateNotYetValid:
                return .sslError("SSL error: \(urlError.localizedDescription)")
            default:
                return .urlSessionFailed(urlError)
            }
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
