//
//  ApplicationService.swift
//
//
//  Created by Artemy Volkov on 12.03.2024.
//

import Combine

public struct ApplicationService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.applicationBaseURLs)
    
    public init() {}
    
    public func createApplication(with applicationEntity: RGApplicationEntityCore) ->
    AnyPublisher<ResultData<RGApplicationViewModel>, NetworkRequestError> {
        
        let request = ApplicationPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            applicationEntity: applicationEntity
        )
        return apiClient.dispatch(request)
    }
    
    public func updateApplication(with applicationEntity: RGApplicationViewModel) ->
    AnyPublisher<ResultData<RGApplicationViewModel>, NetworkRequestError> {
            
            let request = ApplicationPATCHRequest(
                accessToken: AuthStorage.shared.getAccessToken(),
                applicationEntity: applicationEntity
            )
            return apiClient.dispatch(request)
    }
    
    public func fetchApplications(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGApplicationViewModel>, NetworkRequestError> {
        let request = ApplicationListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
