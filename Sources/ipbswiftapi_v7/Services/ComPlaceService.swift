//
//  ComPlaceService.swift
//
//
//  Created by Artemy Volkov on 15.12.2023.
//

import Combine

/// Manages operations related to commercial places, such as retrieving a list of places based on filter and sort criteria.
///
/// `ComPlaceService` uses an `APIClient` to make network requests to commercial place-related endpoints configured in `IPBSettings.comPlaceBaseURLs`. Its primary functionality includes fetching a list of commercial places based on specified filtering and sorting criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Commercial Place Operations
///
/// - ``getComPlaceList(with:)``
///
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
