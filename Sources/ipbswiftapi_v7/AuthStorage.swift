import Foundation

public class AuthStorage: ObservableObject {
    
    public static let shared = AuthStorage()
    
    @Published public var isLoggedIn: Bool = false
    
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
        _ = KeychainUtility.save(key: key, data: data)
        updateLoginStatus()
    }
    
    private func loadToken(forKey key: String) -> String? {
        guard let data = KeychainUtility.load(key: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    private func removeToken(forKey key: String) {
        _ = KeychainUtility.delete(key: key)
    }
    
    private func updateLoginStatus() {
        isLoggedIn = refreshTokenCache != nil
    }
}

extension AuthStorage {
    public func getAccessToken() -> String {
        accessTokenCache ?? loadToken(forKey: accessTokenKey) ?? ""
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
        removeToken(forKey: accessTokenKey)
        removeToken(forKey: refreshTokenKey)
        accessTokenCache = nil
        refreshTokenCache = nil
        updateLoginStatus()
    }
}
