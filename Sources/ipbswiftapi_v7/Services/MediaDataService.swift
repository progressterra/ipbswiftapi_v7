//
//  MediaDataService.swift
//
//
//  Created by Artemy Volkov on 24.08.2023.
//

import Combine

/// Handles operations related to media data for clients and entities.
///
/// `MediaDataService` provides methods to add, fetch, and delete media data, leveraging the `APIClient` for network communications with media data-related endpoints configured in `IPBSettings`.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Media Data Operations
///
/// - ``addMediaDataForClient(_:typeContent:alias:tag:)``
/// - ``addMediaDataForEntity(_:medias:typeContent:entityTypeName:alias:tag:)``
/// - ``fetchListMediaDataForClient(with:)``
/// - ``fetchListMediaDataFor(entityID:with:)``
/// - ``deleteMediaDataByID(_:)``
///
public struct MediaDataService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.mediaDataBaseURLs)
    
    public init() {}
    
    /// Adds media data for a client.
    /// - Parameters:
    ///   - medias: An array of `MediaModel` representing the media to add.
    ///   - typeContent: The type of content being added.
    ///   - alias: A string alias for the media.
    ///   - tag: An integer tag associated with the media.
    /// - Returns: A publisher that emits `ResultData<RGEntityMediaDataViewModel>` upon success or a `NetworkRequestError` on failure.
    public func addMediaDataForClient(
        _ medias: [MediaModel],
        typeContent: TypeContent,
        alias: String,
        tag: Int
    ) -> AnyPublisher<ResultData<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataClientPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            typeContent: typeContent,
            alias: alias,
            tag: tag,
            medias: medias
        )
        return apiClient.dispatch(request)
    }
    
    /// Adds media data for a specified entity.
    /// - Parameters:
    ///   - idEntity: The identifier of the entity for which media is being added.
    ///   - medias: An array of `MediaModel` for the media to add.
    ///   - typeContent: The type of content being added.
    ///   - entityTypeName: The name of the entity type.
    ///   - alias: A string alias for the media.
    ///   - tag: An integer tag associated with the media.
    /// - Returns: A publisher that emits `ResultData<RGEntityMediaDataViewModel>` upon success or a `NetworkRequestError` on failure.
    public func addMediaDataForEntity(
        _ idEntity: String,
        medias: [MediaModel],
        typeContent: TypeContent,
        entityTypeName: String,
        alias: String,
        tag: Int
    ) -> AnyPublisher<ResultData<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataEntityPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idEntity: idEntity,
            typeContent: typeContent,
            entityTypeName: entityTypeName,
            alias: alias,
            tag: tag,
            medias: medias
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of media data for a client.
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria.
    /// - Returns: A publisher emitting `ResultDataList<RGEntityMediaDataViewModel>` containing the list of media data or a `NetworkRequestError` on failure.
    public func fetchListMediaDataForClient(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataClientListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of media data for a specified entity.
    /// - Parameters:
    ///   - entityID: The identifier of the entity for which to fetch media data.
    ///   - filter: A `FilterAndSort` object specifying filtering and sorting criteria.
    /// - Returns: A publisher emitting `ResultDataList<RGEntityMediaDataViewModel>` or a `NetworkRequestError` on failure.
    public func fetchListMediaDataFor(entityID: String, with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataEntityByIDListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idEntity: entityID,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Deletes media data by its identifier.
    /// - Parameter idMediaEntity: The identifier of the media entity to delete.
    /// - Returns: A publisher that emits `ResultData<EmptyResultOperation>` upon success or a `NetworkRequestError` on failure.
    public func deleteMediaDataByID(_ idMediaEntity: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = MediaDataDELETEByIDRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idMediaEntity: idMediaEntity
        )
        return apiClient.dispatch(request)
    }
}
