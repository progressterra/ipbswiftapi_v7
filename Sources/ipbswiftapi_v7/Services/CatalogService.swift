//
//  CatalogService.swift
//
//
//  Created by Artemy Volkov on 10.07.2023.
//

import Combine

/// Manages fetching catalog data, including items and categories.
///
/// `CatalogService` uses an `APIClient` to make network requests to predefined catalog base URLs set in `IPBSettings`. It provides functionality to retrieve catalog items and categories based on specific criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Catalog Operations
///
/// - ``getCatalog(with:)``
/// - ``getCatalogCategory(by:)``
///
public struct CatalogService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.catalogBaseURLs)
    
    public init() {}
    
    // Retrieves catalog items filtered by the given criteria.
    ///
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the catalog items to be retrieved.
    /// - Returns: A publisher that emits a `ResultData<CatalogItem>` upon successful retrieval or a `NetworkRequestError` on failure.
    ///
    /// `CatalogItem` contains `RFCatalogCategoryViewModel` and nested array of `CatalogItem`.
    public func getCatalog(with filter: FilterAndSort) ->
    AnyPublisher<ResultData<CatalogItem>, NetworkRequestError> {
        
        let request = CatalogRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves a specific catalog category by its identifier.
    ///
    /// - Parameter categoryID: A string identifier for the category to be retrieved.
    /// - Returns: A publisher that emits `ResultData<RFCatalogCategoryViewModel>` upon successful retrieval or a `NetworkRequestError` on failure.
    ///
    /// This method requests data for a specific catalog category. The response includes information conforming to the `RFCatalogCategoryViewModel`, which provides details about the category, such as its name and associated items.
    public func getCatalogCategory(by categoryID: String) ->
    AnyPublisher<ResultData<RFCatalogCategoryViewModel>, NetworkRequestError> {
        
        let request = CatalogCategoryRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCategory: categoryID
        )
        return apiClient.dispatch(request)
    }
}
