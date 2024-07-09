//
//  SCRMService.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

import Combine

/// Provides services related to client relationship management (SCRM).
///
/// `SCRMService` uses an `APIClient` to make network requests for operations such as fetching client data, updating client information, and managing device tokens.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Client Data Operations
///
/// - ``getClientData()``
/// - ``patсhClientData(with:)``
/// - ``setEmail(_:)``
/// - ``uploadDeviceToken(_:)``
///
public struct SCRMService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.sCRMBaseURLs)
    
    public init() {}
    
    /// Fetches the current client data.
    /// - Returns: A publisher emitting `ResultData<ClientsViewModel>` upon success or a `NetworkRequestError` on failure.
    public func getClientData() ->
    AnyPublisher<ResultData<ClientsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    /// Updates client data with the provided entity.
    /// - Parameter clientsEntity: A `ClientsEntity` containing the new or updated client data.
    /// - Returns: A publisher emitting `ResultData<ClientsViewModel>` upon successful update or a `NetworkRequestError` on failure.
    public func patсhClientData(with clientsEntity: ClientsEntity) ->
    AnyPublisher<ResultData<ClientsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPATCHRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            clientsEntity: clientsEntity
        )
        return apiClient.dispatch(request)
    }
    
    /// Updates the client's email address.
    /// - Parameter email: The new email address as a string.
    /// - Returns: A publisher emitting `ResultData<RGClientChannel>` upon success or a `NetworkRequestError` on failure.
    public func setEmail(_ email: String) ->
    AnyPublisher<ResultData<RGClientChannel>, NetworkRequestError> {
        
        let request = ClientAreaEmailPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            email: email
        )
        return apiClient.dispatch(request)
    }
    
    /// Uploads a device token for Push Notifications.
    /// - Parameter tokenData: The device token as a string.
    /// - Returns: A publisher emitting `ResultData<RGDeviceTokenViewModel>` upon success or a `NetworkRequestError` on failure.
    public func uploadDeviceToken(_ tokenData: String) ->
    AnyPublisher<ResultData<RGDeviceTokenViewModel>, NetworkRequestError> {
        
        let request = DeviceTokenPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            tokenEntity: RGDeviceTokenEntity(tokenData: tokenData)
        )
        return apiClient.dispatch(request)
    }
}
