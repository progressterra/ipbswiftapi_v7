//
//  PaymentsService.swift
//
//
//  Created by Artemy Volkov on 17.08.2023.
//

import Combine

/// Manages payment-related operations, including creating and retrieving payments.
///
/// `PaymentsService` utilizes an `APIClient` to interact with payment-related endpoints configured in `IPBSettings`. It facilitates operations such as creating new payments, fetching details of a specific payment, and retrieving a list of payments based on certain criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Payment Operations
///
/// - ``createPayment(with:)``
/// - ``fetchPayment(by:)``
/// - ``fetchPaymentList(with:)``
///
public struct PaymentsService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.paymentsBaseURLs)
    
    public init() {}
    
    /// Creates a new payment.
    /// - Parameter entity: A `DHPaymentEntityIncome` object containing the necessary data to create a payment, such as idPaymentData that could be retrieved from the `PaymentDataService`.
    /// - Returns: A publisher emitting `ResultData<DHPaymentClientViewModel>` upon success or a `NetworkRequestError` on failure.
    public func createPayment(with entity: DHPaymentEntityIncome) ->
    AnyPublisher<ResultData<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            paymentEntity: entity
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves details of a specific payment by its unique identifier.
    /// - Parameter id: The unique identifier of the payment to be retrieved.
    /// - Returns: A publisher emitting `ResultData<DHPaymentClientViewModel>` upon success or a `NetworkRequestError` on failure.
    public func fetchPayment(by id: String) ->
    AnyPublisher<ResultData<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentByIDGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idUnique: id
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves a list of payments based on the provided filter and sort criteria.
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the payments to be retrieved.
    /// - Returns: A publisher emitting `ResultDataList<DHPaymentClientViewModel>` containing the list of payments or a `NetworkRequestError` on failure.
    public func fetchPaymentList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
