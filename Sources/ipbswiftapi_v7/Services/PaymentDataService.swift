//
//  PaymentDataService.swift
//  
//
//  Created by Artemy Volkov on 16.08.2023.
//

import Combine

public struct PaymentDataService {
    
    private let apiClient = APIClient(baseURL: IPBSettings.paymentDataBaseURL)
    
    public init() {}
    
    public func fetchPaymentDataList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RFPaymentDataForClientViewModel>, NetworkRequestError> {
        
        let request = PaymentDataListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        
        return apiClient.dispatch(request)
    }
}
