//
//  AuthStorage.swift
//
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Foundation
import Combine

/// Manages authentication token storage and refresh functionality.
///
/// `AuthStorage` is a singleton class responsible for storing, retrieving, and refreshing authentication tokens used for network requests. It uses the Keychain for secure token storage and provides mechanisms to refresh tokens as needed. This class also tracks the user's login status based on the presence of tokens.
///
/// ## Topics
///
/// ### Getting Started
///
/// - ``shared``
///
/// ### Checking Login Status
///
/// - ``isLoggedIn``
///
/// ### Token Management
///
/// - ``getAccessToken()``
/// - ``getRefreshToken()``
/// - ``updateTokenStorage(for:)``
/// - ``logout()``
///
public class AuthStorage: ObservableObject {
    
    /// The singleton instance of `AuthStorage`.
    public static let shared = AuthStorage()
    
    /// Published property that indicates whether the user is logged in based on the presence of a refresh token.
    @Published public var isLoggedIn: Bool = false
    
    private let authService = AuthorizationService()
    private let semaphore = DispatchSemaphore(value: 1)
    private var refreshTokenPublisher: AnyPublisher<ResultData<ResultAuthAsJWT>, NetworkRequestError>?
    private var subscriptions = Set<AnyCancellable>()
    
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    private var accessTokenCache: String?
    private var refreshTokenCache: String?
    
    private init() {
        accessTokenCache = loadToken(forKey: accessTokenKey)
        refreshTokenCache = loadToken(forKey: refreshTokenKey)
        updateLoginStatus()
    }
    
    private func saveToken(_ token: String, forKey key: String) {
        guard let data = token.data(using: .utf8) else { return }
        KeychainUtility.save(key: key, data: data)
        updateLoginStatus()
    }
    
    private func loadToken(forKey key: String) -> String? {
        guard let data = KeychainUtility.load(key: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    private func updateLoginStatus() {
        isLoggedIn = !(refreshTokenCache?.isEmpty ?? true)
    }
}

// MARK: Tokens update
extension AuthStorage {
    /// Refreshes the authentication token.
    ///
    /// This method initializes a token refresh process and returns a publisher that emits a completion event on success or an `NetworkRequestError` on failure. It ensures that only one token refresh process is active at a time using `refreshTokenPublisher`.
    ///
    /// - Returns: An `AnyPublisher<Void, NetworkRequestError>` that signals completion or failure of the token refresh operation.
    /// - Initializes `refreshTokenPublisher` if it is `nil`, by calling `authService.refreshToken` with the current refresh token. This publisher is shared and type-erased to `AnyPublisher`.
    /// - Subscribes to `refreshTokenPublisher` and handles the result:
    ///   - On success and if the result status is `.success`, updates the token storage with new data and completes the future with success.
    /// Usage:
    /// - Typically used when an API request returns an unauthorized error, indicating the need for a token refresh.
    internal func refreshToken() -> AnyPublisher<Void, NetworkRequestError> {
        Deferred {
            Future<Void, NetworkRequestError> { [weak self] promise in
                guard let self, !getRefreshToken().isEmpty else {
                    promise(.failure(.customError("Tokens could not be refreshed")))
                    return
                }
                
                if refreshTokenPublisher == nil {
                    semaphore.wait()
                    refreshTokenPublisher = authService.refreshToken(with: getRefreshToken())
                        .handleEvents(receiveCompletion: { _ in
                            self.semaphore.signal()
                            self.refreshTokenPublisher = nil
                        })
                        .share()
                        .eraseToAnyPublisher()
                }
                
                refreshTokenPublisher?
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            promise(.failure(error))
                        case .finished:
                            break
                        }
                    } receiveValue: { [weak self] result in
                        if result.result.status == .success {
                            self?.updateTokenStorage(for: result.data)
                            promise(.success(()))
                        } else {
                            promise(.failure(.customError("Token refresh failed with status: \(result.result.status)")))
                        }
                    }
                    .store(in: &subscriptions)
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Tokens management
extension AuthStorage {
    /// Retrieves the current access token.
    ///
    /// This method returns the access token stored in the Keychain. If no token is stored, it returns a default token for unauthorized users as defined in `IPBSettings`.
    ///
    /// - Returns: The current access token as a `String`.
    public func getAccessToken() -> String {
        accessTokenCache ?? loadToken(forKey: accessTokenKey) ?? IPBSettings.accessTokenForUnauthorizedUser
    }
    
    /// Retrieves the current refresh token.
    ///
    /// This method returns the refresh token stored in the Keychain. If no token is stored, it returns an empty `String`.
    ///
    /// - Returns: The current refresh token as a `String`.
    public func getRefreshToken() -> String {
        refreshTokenCache ?? loadToken(forKey: refreshTokenKey) ?? ""
    }
    
    /// Updates the token storage with new token data.
    ///
    /// This method saves the provided access and refresh tokens to the Keychain and updates the cache. It also updates the login status based on the presence of the refresh token.
    ///
    /// - Parameter data: An optional `ResultAuthAsJWT` containing the new access and refresh tokens.
    public func updateTokenStorage(for data: ResultAuthAsJWT?) {
        if let refreshToken = data?.refreshToken {
            saveToken(refreshToken, forKey: refreshTokenKey)
            refreshTokenCache = refreshToken
        }
        if let accessToken = data?.accessToken {
            saveToken(accessToken, forKey: accessTokenKey)
            accessTokenCache = accessToken
        }
    }
    
    /// Logs out the current user.
    ///
    /// This method clears the stored access and refresh tokens from the Keychain and the cache. It also updates the login status to reflect that the user is no longer logged in.
    public func logout() {
        KeychainUtility.delete(key: accessTokenKey)
        KeychainUtility.delete(key: refreshTokenKey)
        accessTokenCache = nil
        refreshTokenCache = nil
        updateLoginStatus()
    }
}
