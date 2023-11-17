//
//  OrderService.swift
//  
//
//  Created by Artemy Volkov on 31.07.2023.
//

import Combine

public struct OrderService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.cartBaseURLs)
    
    public init() {}
    
    public func getOrderById(_ idOrder: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = OrderByIDGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idOrder: idOrder
        )
        return apiClient.dispatch(request)
    }
    
    public func getOrderList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = OrderListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func changeStatusOrderByID(_ idOrder: String, newStatus: TypeStatusOrder) ->
    AnyPublisher<ResultDataList<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = OrderChangeStatusByIDPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idOrder: idOrder,
            statusType: newStatus
        )
        return apiClient.dispatch(request)
    }
}
