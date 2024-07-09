//
//  PaymentDataService.swift
//
//
//  Created by Artemy Volkov on 16.08.2023.
//

import Combine

/// Handles retrieval operations for payment data.
///
/// `PaymentDataService` uses an `APIClient` for making network requests to endpoints configured under `IPBSettings.paymentDataBaseURLs`. Its main functionality includes fetching a list of payment data entries based on specified criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Payment Data Operations
///
/// - ``fetchPaymentDataList(with:)``
///
public struct PaymentDataService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.paymentDataBaseURLs)
    
    public init() {}
    
    /// Fetches a list of payment data entries.
    ///
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the payment data entries to be retrieved.
    /// - Returns: A publisher emitting `ResultDataList<RFPaymentDataForClientViewModel>` containing the list of payment data entries or a `NetworkRequestError` on failure.
    public func fetchPaymentDataList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RFPaymentDataForClientViewModel>, NetworkRequestError> {
        
        let request = PaymentDataListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        
        return apiClient.dispatch(request)
    }
}
