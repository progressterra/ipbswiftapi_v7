//
//  CatalogService.swift
//
//
//  Created by Artemy Volkov on 10.07.2023.
//

import Combine

public struct CatalogService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.catalogBaseURLs)
    
    public init() {}
    
    public func getCatalog(with filter: FilterAndSort) ->
    AnyPublisher<ResultData<CatalogItem>, NetworkRequestError> {
        
        let request = CatalogRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func getCatalogCategory(by categoryID: String) ->
    AnyPublisher<ResultData<RFCatalogCategoryViewModel>, NetworkRequestError> {
        
        let request = CatalogCategoryRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCategory: categoryID
        )
        return apiClient.dispatch(request)
    }
}
