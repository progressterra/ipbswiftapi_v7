//
//  AuthStorage.swift
//  
//
//  Created by Artemy Volkov on 08.07.2023.
//

import Foundation

public class AuthStorage: ObservableObject {
    public static let shared = AuthStorage()
    
    public enum LoginStatus {
        case loggedIn
        case loggedOut
    }
    /// Observable property for login status
    @Published public var isLoggedIn: Bool = false
    
    private let userDefaults = UserDefaults.standard
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    private init() {
        updateLoginStatus()
    }
    
    private func saveRefreshToken(_ token: String?) {
        userDefaults.set(token, forKey: refreshTokenKey)
        updateLoginStatus()
    }
    
    private func saveAccessToken(_ token: String?) {
        userDefaults.set(token, forKey: accessTokenKey)
        updateLoginStatus()
    }
    
    private func updateLoginStatus() {
        isLoggedIn = userDefaults.string(forKey: refreshTokenKey) != nil
    }
}

extension AuthStorage {
    public func getAccessToken() -> String {
        userDefaults.string(forKey: accessTokenKey) ?? ""
    }
    
    public func getRefreshToken() -> String {
        userDefaults.string(forKey: refreshTokenKey) ?? ""
    }
    
    public func logout() {
        userDefaults.removeObject(forKey: refreshTokenKey)
        userDefaults.removeObject(forKey: accessTokenKey)
        updateLoginStatus()
    }
    
    public func updateTokenStorage(for data: ResultAuthAsJWT?) {
        if let refreshToken = data?.refreshToken {
            saveRefreshToken(refreshToken)
        }
        if let accessToken = data?.accessToken {
            saveAccessToken(accessToken)
        }
    }
}
