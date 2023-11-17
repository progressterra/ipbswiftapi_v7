//
//  ProductService.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Combine

public struct ProductService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.productBaseURLs)
    
    public init() {}
    
    public func getProductByID(idRFNomenclature: String) ->
    AnyPublisher<ResultData<ProductViewDataModel>, NetworkRequestError> {
        
        let request = ProductByIDRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idRFNomenclature: idRFNomenclature
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchProductList(for identifier: String, using filter: FilterAndSort) -> AnyPublisher<ResultDataList<ProductViewDataModel>, NetworkRequestError> {
        
        let request = ProductListRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
