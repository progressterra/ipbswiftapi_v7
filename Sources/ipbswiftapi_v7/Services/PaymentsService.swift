//
//  PaymentsService.swift
//  
//
//  Created by Artemy Volkov on 17.08.2023.
//

import Combine

public struct PaymentsService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.paymentsBaseURLs)
    
    public init() {}
    
    public func createPayment(with entity: DHPaymentEntityIncome) ->
    AnyPublisher<ResultData<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            paymentEntity: entity
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchPayment(by id: String) ->
    AnyPublisher<ResultData<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentByIDGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idUnique: id
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchPaymentList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHPaymentClientViewModel>, NetworkRequestError> {
        
        let request = ClientAreaPaymentListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
