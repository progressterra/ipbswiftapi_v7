import Foundation
import Combine

public class AuthStorage: ObservableObject {
    
    public static let shared = AuthStorage()
    
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
        guard let data = token.data(using: .utf8) else {
            print("Failed to convert token to Data for key: \(key)")
            return
        }
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
                guard let self else {
                    promise(.failure(.customError("AuthStorage is deallocated")))
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
    public func getAccessToken() -> String {
        accessTokenCache ?? loadToken(forKey: accessTokenKey) ?? IPBSettings.accessTokenForUnauthorizedUser
    }
    
    public func getRefreshToken() -> String {
        refreshTokenCache ?? loadToken(forKey: refreshTokenKey) ?? ""
    }
    
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
    
    public func logout() {
        KeychainUtility.delete(key: accessTokenKey)
        KeychainUtility.delete(key: refreshTokenKey)
        accessTokenCache = nil
        refreshTokenCache = nil
        updateLoginStatus()
    }
}
