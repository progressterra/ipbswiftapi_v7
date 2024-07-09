//
//  BalanceService.swift
//
//
//  Created by Artemy Volkov on 18.08.2023.
//

import Combine

/// Manages operations related to the client's internal balance within the application.
///
/// `BalanceService` utilizes an `APIClient` to make network requests to balance-related endpoints as configured in `IPBSettings.balanceRegisterBaseURLs`. Its primary function is to retrieve the current balance of a client, reflecting any movements, credits, or debits in the internal system.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Balance Operations
///
/// - ``getClientBalance()``
///
public struct BalanceService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.balanceRegisterBaseURLs)
    
    public init() {}
    
    /// Retrieves the current internal balance for the client.
    ///
    /// - Returns: A publisher emitting `ResultData<RGMoveDataEntityAmount>` upon success, containing the balance information, or a `NetworkRequestError` on failure.
    public func getClientBalance() ->
    AnyPublisher<ResultData<RGMoveDataEntityAmount>, NetworkRequestError> {
        
        let request = BalanceClientGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        
        return apiClient.dispatch(request)
    }
}
