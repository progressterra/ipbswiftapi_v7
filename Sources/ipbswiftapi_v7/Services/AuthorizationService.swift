//
//  AuthorizationService.swift
//
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Combine

public struct AuthorizationService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.clientLoginBaseURLs)
    
    public init() {}
    
    public func startLogin(with phoneNumber: String) ->
    AnyPublisher<ResultData<ResultSendCodeForClient>, NetworkRequestError> {

        let request = StartLoginRequest(
            phone: phoneNumber,
            accessKeyEnterprise: IPBSettings.accessKeyEnterprise
        )
        return apiClient.dispatch(request)
    }
    
    public func endLogin(with codeFromSMS: String, tempToken: String) ->
    AnyPublisher<ResultData<ResultAuthAsJWT>, NetworkRequestError> {
        
        let request = EndLoginRequest(
            tempToken: tempToken,
            codeFromSMS: codeFromSMS
        )
        return apiClient.dispatch(request)
    }
    
    public func refreshToken(with refreshToken: String) ->
    AnyPublisher<ResultData<ResultAuthAsJWT>, NetworkRequestError> {
        
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        return apiClient.dispatch(request)
    }
    
    public func logoutAllTokens(userId: String, accessToken: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = LogoutAllTokensRequest(
            userId: userId,
            accessToken: accessToken
        )
        return apiClient.dispatch(request)
    }
    
    public func logoutToken(refreshToken: String, accessToken: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = LogoutTokenRequest(
            refreshToken: refreshToken,
            accessToken: accessToken
        )
        return apiClient.dispatch(request)
    }
}
