//
//  MediaDataService.swift
//  
//
//  Created by Artemy Volkov on 24.08.2023.
//

import Combine

public struct MediaDataService {
    
    private let apiClient = APIClient(baseURL: IPBSettings.mediaDataBaseURL)
    
    public init() {}
    
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
    
    public func fetchListMediaDataForClient(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataClientListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchListMediaDataFor(entityID: String, with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGEntityMediaDataViewModel>, NetworkRequestError> {
        
        let request = MediaDataEntityByIDListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idEntity: entityID,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
