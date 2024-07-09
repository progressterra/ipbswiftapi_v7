//
//  AuthorizationService.swift
//
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Combine

/// Manages the authorization process for the application.
///
/// `AuthorizationService` provides a suite of methods to handle the login process, token refreshing, and user logout functionality. It leverages an `APIClient` to communicate with the specified authentication endpoints defined in `IPBSettings`.
///
/// ## Usage
///
/// Before using any of the service methods, ensure `IPBSettings` is correctly configured with the necessary URLs and keys.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Authentication Processes
///
/// - ``startLogin(with:)``
/// - ``endLogin(with:tempToken:)``
/// - ``refreshToken(with:)``
/// - ``logoutAllTokens(userId:accessToken:)``
/// - ``logoutToken(refreshToken:accessToken:)``
///
public struct AuthorizationService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.clientLoginBaseURLs)
    
    public init() {}
    
    /// Initiates the login process with a phone number.
    ///
    /// - Parameter phoneNumber: The phone number used to start the login process.
    /// - Returns: A publisher that emits a `ResultData<ResultSendCodeForClient>` upon completion or an `NetworkRequestError` on failure.
    ///
    /// The method sends a login request to the server and expects a temporary token or an error response.
    public func startLogin(with phoneNumber: String) ->
    AnyPublisher<ResultData<ResultSendCodeForClient>, NetworkRequestError> {
        
        let request = StartLoginRequest(
            phone: phoneNumber,
            accessKeyEnterprise: IPBSettings.accessKeyEnterprise
        )
        return apiClient.dispatch(request)
    }
    
    /// Completes the login process with an SMS code and a temporary token.
    ///
    /// - Parameters:
    ///   - codeFromSMS: The verification code sent via SMS to the user.
    ///   - tempToken: A temporary token received during the start login process.
    /// - Returns: A publisher that emits `ResultData<ResultAuthAsJWT>` contains an access token and refresh token on success or an `NetworkRequestError` on failure.
    ///
    /// This method verifies the SMS code with the server to complete the user's login process.
    /// Received tokens should be saved with ``AuthStorage/updateTokenStorage(for:)``.
    public func endLogin(with codeFromSMS: String, tempToken: String) ->
    AnyPublisher<ResultData<ResultAuthAsJWT>, NetworkRequestError> {
        
        let request = EndLoginRequest(
            tempToken: tempToken,
            codeFromSMS: codeFromSMS
        )
        return apiClient.dispatch(request)
    }
    
    /// Refreshes the authentication token using a refresh token.
    ///
    /// - Parameter refreshToken: The refresh token used to obtain a new access token.
    /// - Returns: A publisher that emits `ResultData<ResultAuthAsJWT>` on success or an `NetworkRequestError` on failure.
    ///
    /// Use this method to refresh the user's authentication tokens when the access token has expired. 
    /// Received tokens should be updated with ``AuthStorage/updateTokenStorage(for:)``.
    public func refreshToken(with refreshToken: String) ->
    AnyPublisher<ResultData<ResultAuthAsJWT>, NetworkRequestError> {
        
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        return apiClient.dispatch(request)
    }
    
    /// Logs out all sessions for a user identified by the userId.
    ///
    /// - Parameters:
    ///   - userId: The user's identifier.
    ///   - accessToken: The access token of the current session.
    /// - Returns: A publisher that emits `ResultData<EmptyResultOperation>` on success or an `NetworkRequestError` on failure.
    ///
    /// This method invalidates all tokens associated with the user account.
    public func logoutAllTokens(userId: String, accessToken: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = LogoutAllTokensRequest(
            userId: userId,
            accessToken: accessToken
        )
        return apiClient.dispatch(request)
    }
    
    /// Logs out a specific session using a refresh token.
    ///
    /// - Parameters:
    ///   - refreshToken: The refresh token of the session to be logged out.
    ///   - accessToken: The access token of the current session.
    /// - Returns: A publisher that emits `ResultData<EmptyResultOperation>` on success or an `NetworkRequestError` on failure.
    ///
    /// Use this method to logout a specific session identified by the refresh token.
    public func logoutToken(refreshToken: String, accessToken: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = LogoutTokenRequest(
            refreshToken: refreshToken,
            accessToken: accessToken
        )
        return apiClient.dispatch(request)
    }
}
