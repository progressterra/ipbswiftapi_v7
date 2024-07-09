//
//  APIClient.swift
//
//
//  Created by Artemy Volkov on 08.07.2023.
//

import Combine
import Foundation

/// A network client for dispatching requests to a server.
///
/// `APIClient` is responsible for managing network requests to specified base URLs. It utilizes a ``NetworkDispatcher`` to handle the actual request dispatching and response handling, including decoding of the response data.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init(baseURLs:networkDispatcher:)``
///
/// ### Making Requests
///
/// - ``dispatch(_:token:)``
///
public final class APIClient {
    
    /// The list of base URLs to be used for network requests.
    ///
    /// The client will attempt to dispatch requests to these URLs in order until a successful response is received or all URLs have been tried.
    let baseURLs: [String]
    let networkDispatcher: NetworkDispatcher
    
    private var retryCount: Int = 0
    private var currentURLIndex: Int = 0
    
    /// Initializes a new `APIClient` with the specified base URLs and network dispatcher.
    ///
    /// - Parameters:
    ///   - baseURLs: An array of base URL strings to which the client can send requests.
    ///   - networkDispatcher: The `NetworkDispatcher` instance used for dispatching network requests. Defaults to a default-initialized `NetworkDispatcher`.
    public init(
        baseURLs: [String],
        networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    ) {
        self.baseURLs = baseURLs
        self.networkDispatcher = networkDispatcher
    }
    
    /// Dispatches a `Request` and returns a publisher emitting the decoded response or an `NetworkRequestError`.
    ///
    /// This method creates a `URLRequest` from the provided `Request` instance and dispatches it using the `NetworkDispatcher`.
    /// If token is expired it will try to refresh it and retry the request automatically.
    /// If ssl, timeout or network error occurs it will automatically switch to another base URL if any or throw an error.
    /// If the request fails or decoding fails, it emits a `NetworkRequestError` that contains the error message ready for UI.
    ///
    /// - Parameters:
    ///   - request: The `Request` instance representing the network request to be dispatched.
    ///   - token: An optional token string used for retrying the request with a refreshed token. This parameter should not be used directly.
    /// - Returns: A publisher that emits the decoded response data on success or a `NetworkRequestError` on failure.
    public func dispatch<R: Request>(_ request: R, token: String? = nil) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURLs[currentURLIndex], token: token) else {
            return Fail(outputType: R.ReturnType.self, failure: .badRequest("Ошибка запроса"))
                .eraseToAnyPublisher()
        }
        
        if IPBSettings.isLoggingEnabled {
            debugPrintURLRequest(urlRequest)
        }
        
        return networkDispatcher.dispatch(request: urlRequest)
            .tryMap { (output: R.ReturnType) -> R.ReturnType in
                switch output.result.status {
                case .success:
                    return output
                case .warning:
                    print("Warning ⚠️ \(String(describing: output.result.message ?? ""))")
                    throw NetworkRequestError.customError(output.result.message ?? "")
                case .errorServer:
                    print("Error Server ☁️ \(String(describing: output.result.message ?? ""))")
                    throw NetworkRequestError.serverError(output.result.message ?? "")
                case .errorAuth:
                    print("Error Authorization ❌ \(String(describing: output.result.message ?? ""))")
                    throw NetworkRequestError.unauthorized
                case .errorAccess:
                    print("Error Access 🔒 \(String(describing: output.result.message ?? ""))")
                    throw NetworkRequestError.forbidden(output.result.message ?? "")
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkRequestError {
                    return networkError
                } else {
                    return .unknownError("Непредвиденная ошибка ❌")
                }
            }
            .catch { [weak self] error -> AnyPublisher<R.ReturnType, NetworkRequestError> in
                guard let self else {
                    return Fail(error: .customError("APIClient has been deallocated")).eraseToAnyPublisher()
                }
                
                switch error {
                case .unauthorized:
                    return AuthStorage.shared.refreshToken()
                        .flatMap { self.dispatch(request, token: AuthStorage.shared.getAccessToken()) }
                        .eraseToAnyPublisher()
                case .sslError(_), .timeoutError(_), .networkError(_):
                    if retryCount < baseURLs.count - 1 {
                        switchToNextURL()
                        return dispatch(request)
                    }
                    fallthrough
                default:
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func switchToNextURL() {
        currentURLIndex = (currentURLIndex + 1) % baseURLs.count
        retryCount += 1
    }
    
    private func debugPrintURLRequest(_ request: URLRequest) {
        print("\n--- Request Start ---")
        defer { print("--- Request End ---\n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        let port = "\(urlComponents?.port?.intValue.description ?? "")"
        
        print("\n\(method) \(path)?\(query) HTTP/1.1 \nHOST: \(host)\nPORT:\(port)")
        
        if let headers = request.allHTTPHeaderFields {
            print("--- Request Headers ---")
            for (headerField, value) in headers {
                print("\(headerField): \(value)")
            }
        }
        
        if let body = request.httpBody {
            print("\n--- Request Body ---")
            let bodyString = String(data: body, encoding: .utf8) ?? "Can't render body; not a UTF-8 sequence"
            print(bodyString)
        }
    }
}
