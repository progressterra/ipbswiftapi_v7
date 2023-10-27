//
//  NetworkService.swift
//  
//
//  Created by Artemy Volkov on 08.07.2023.
//

import Combine
import Foundation

public struct NetworkDispatcher {
    
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    
    public init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoderUtility.customDateDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    public func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                print("Response: " + response.debugDescription)
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                return data
            }
            .decode(type: ReturnType.self, decoder: jsonDecoder)
            .mapError { error in
                print("Error: \(error)")
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest("Network Error 400\nBad Request")
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
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
