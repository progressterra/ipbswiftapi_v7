//
//  OrderService.swift
//
//
//  Created by Artemy Volkov on 31.07.2023.
//

import Combine

/// Manages operations related to orders, including retrieval and status updates.
///
/// `OrderService` leverages an `APIClient` to make network requests to order-related endpoints as specified in `IPBSettings.cartBaseURLs`. It facilitates operations such as retrieving detailed information about a specific order by its ID, fetching a list of orders based on certain criteria, and updating the status of an order.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Order Operations
///
/// - ``getOrderById(_:)``
/// - ``getOrderList(with:)``
/// - ``changeStatusOrderByID(_:newStatus:)``
///
public struct OrderService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.cartBaseURLs)
    
    public init() {}
    
    /// Fetches details of a specific order by its unique identifier.
    /// - Parameter idOrder: The unique identifier of the order to be retrieved.
    /// - Returns: A publisher emitting `ResultData<DHSaleHeadAsOrderViewModel>` upon success or a `NetworkRequestError` on failure.
    public func getOrderById(_ idOrder: String) ->
    AnyPublisher<ResultData<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = OrderByIDGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idOrder: idOrder
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of orders based on the provided filter and sort criteria.
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the orders to be retrieved.
    /// - Returns: A publisher emitting `ResultDataList<DHSaleHeadAsOrderViewModel>` containing the list of orders or a `NetworkRequestError` on failure.
    public func getOrderList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHSaleHeadAsOrderViewModel>, NetworkRequestError> {
        
        let request = OrderListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Changes the status of an order by its unique identifier to a new status.
    /// - Parameters:
    ///   - idOrder: The unique identifier of the order whose status is to be changed.
    ///   - newStatus: The new status to be applied to the order, represented by `TypeStatusOrder`.
    /// - Returns: A publisher emitting `ResultDataList<DHSaleHeadAsOrderViewModel>` reflecting the updated order status or a `NetworkRequestError` on failure.
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
