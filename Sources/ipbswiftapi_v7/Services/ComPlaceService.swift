//
//  ComPlaceService.swift
//
//
//  Created by Artemy Volkov on 15.12.2023.
//

import Combine

public struct ComPlaceService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.comPlaceBaseURLs)
    
    public init() {}
    
    public func getComPlaceList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RFComPlaceViewModel>, NetworkRequestError> {
        
        let request = ComPlaceListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
