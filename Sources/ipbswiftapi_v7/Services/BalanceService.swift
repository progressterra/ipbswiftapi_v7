//
//  BalanceService.swift
//  
//
//  Created by Artemy Volkov on 18.08.2023.
//

import Combine

public struct BalanceService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.balanceRegisterBaseURLs)
    
    public init() {}
    
    public func getClientBalance() ->
    AnyPublisher<ResultData<RGMoveDataEntityAmount>, NetworkRequestError> {
        
        let request = BalanceClientGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        
        return apiClient.dispatch(request)
    }
}
