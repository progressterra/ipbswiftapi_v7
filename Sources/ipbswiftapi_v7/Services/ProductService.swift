//
//  ProductService.swift
//
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Combine

/// Manages product-related operations, including retrieving individual products and fetching lists of products.
///
/// `ProductService` leverages an `APIClient` to make network requests to product-related endpoints as specified in `IPBSettings`. It offers functionality to retrieve detailed information about a specific product by its ID and to fetch a list of products based on certain criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Product Operations
///
/// - ``getProductByID(idRFNomenclature:)``
/// - ``fetchProductList(for:using:)``
///
public struct ProductService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.productBaseURLs)
    
    public init() {}
    
    /// Retrieves detailed information about a specific product by its identifier.
    /// - Parameter idRFNomenclature: The identifier of the product to be retrieved.
    /// - Returns: A publisher that emits `ResultData<ProductViewDataModel>` upon success or a `NetworkRequestError` on failure.
    ///
    /// This method sends a request to fetch detailed data for a product identified by `idRFNomenclature`. The response includes data conforming to the `ProductViewDataModel`, providing comprehensive details about the product.
    public func getProductByID(idRFNomenclature: String) ->
    AnyPublisher<ResultData<ProductViewDataModel>, NetworkRequestError> {
        
        let request = ProductByIDRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idRFNomenclature: idRFNomenclature
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of products based on the provided criteria.
    /// - Parameters:
    ///   - identifier: The identifier of the product category to retrieve products from.
    ///   - filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the products to be retrieved.
    /// - Returns: A publisher emitting `ResultDataList<ProductViewDataModel>` containing the list of products or a `NetworkRequestError` on failure.
    public func fetchProductList(for identifier: String, using filter: FilterAndSort) -> AnyPublisher<ResultDataList<ProductViewDataModel>, NetworkRequestError> {
        
        let request = ProductListRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
