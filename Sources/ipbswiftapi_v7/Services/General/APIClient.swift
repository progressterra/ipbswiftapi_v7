//
//  APIClient.swift
//  
//
//  Created by Artemy Volkov on 08.07.2023.
//

import Combine
import Foundation

public struct APIClient {
    
    let baseURL: String!
    let networkDispatcher: NetworkDispatcher!
    
    public init(
        baseURL: String,
        networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    ) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    public func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest("Ошибка запроса"))
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
            .mapError { error -> NetworkRequestError in
                if let networkError = error as? NetworkRequestError {
                    return networkError
                } else {
                    return .unknownError("Непредвиденная ошибка")
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func debugPrintURLRequest(_ request: URLRequest) {
        print("\n--- Request Start ---")
        defer { print("--- Request End ---\n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
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
