//
//  ApplicationService.swift
//
//
//  Created by Artemy Volkov on 12.03.2024.
//

import Combine

/// Manages operations related to applications, including creation, updates, and fetching.
///
/// `ApplicationService` utilizes an `APIClient` to communicate with the backend, performing actions such as creating new applications, updating existing ones, and fetching a list of applications based on specific criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Application Management
///
/// - ``createApplication(with:)``
/// - ``updateApplication(with:)``
/// - ``fetchApplications(with:)``
///
public struct ApplicationService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.applicationBaseURLs)
    
    public init() {}
    
    /// Creates a new application entity.
    ///
    /// - Parameter applicationEntity: An `RGApplicationEntityCore` object containing the application's initial data.
    /// - Returns: A publisher that emits a `ResultData<RGApplicationViewModel>` upon successful creation or an `NetworkRequestError` on failure.
    public func createApplication(with applicationEntity: RGApplicationEntityCore) ->
    AnyPublisher<ResultData<RGApplicationViewModel>, NetworkRequestError> {
        
        let request = ApplicationPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            applicationEntity: applicationEntity
        )
        return apiClient.dispatch(request)
    }
    
    /// Updates an existing application entity.
    ///
    /// - Parameter applicationEntity: An `RGApplicationViewModel` object containing the updated data for the application.
    /// - Returns: A publisher that emits a `ResultData<RGApplicationViewModel>` upon successful update or an `NetworkRequestError` on failure.
    public func updateApplication(with applicationEntity: RGApplicationViewModel) ->
    AnyPublisher<ResultData<RGApplicationViewModel>, NetworkRequestError> {
        
        let request = ApplicationPATCHRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            applicationEntity: applicationEntity
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of applications based on the provided filter and sort criteria.
    ///
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria.
    /// - Returns: A publisher that emits a `ResultDataList<RGApplicationViewModel>` containing the list of applications or an `NetworkRequestError` on failure.
    public func fetchApplications(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGApplicationViewModel>, NetworkRequestError> {
        let request = ApplicationListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
}
