//
//  SCRMService.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

import Combine

public struct SCRMService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.sCRMBaseURLs)
    
    public init() {}
    
    public func getClientData() ->
    AnyPublisher<ResultData<ClientsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }

    public func patсhClientData(with clientsEntity: ClientsEntity) ->
    AnyPublisher<ResultData<ClientsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPATCHRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            clientsEntity: clientsEntity
        )
        return apiClient.dispatch(request)
    }
    
    public func uploadDeviceToken(_ tokenData: String) ->
    AnyPublisher<ResultData<RGDeviceTokenViewModel>, NetworkRequestError> {
        
        let request = DeviceTokenPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            tokenEntity: RGDeviceTokenEntity(tokenData: tokenData)
        )
        return apiClient.dispatch(request)
    }
    
    public func setEmail(_ email: String) ->
    AnyPublisher<ResultData<RGClientChannel>, NetworkRequestError> {
        
        let request = ClientAreaEmailPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            email: email
        )
        return apiClient.dispatch(request)
    }
}
