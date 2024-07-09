//
//  ChecklistService.swift
//
//  Created by Artemy Volkov on 19.12.2023.
//

import Combine

/// Manages operations related to checklists and their associated actions within the application.
///
/// `ChecklistService` uses an `APIClient` to interact with checklist-related endpoints, facilitating various operations such as answering checklist items, fetching lists of commercial places and checklists, and managing documents and reports associated with checklists.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Checklist Operations
///
/// - ``answerChecklistItem(with:)``
/// - ``fetchComPlaceList()``
/// - ``fetchChecklistList(for:)``
/// - ``fetchDocumentList(for:with:)``
/// - ``fetchCheckPerformedItems(for:)``
/// - ``fetchPerformedChecklistList(with:)``
/// - ``fetchChecklistItems(with:idRFCheck:)``
/// - ``finishCheck(for:with:)``
/// - ``sendReportToEmail(for:)``
/// - ``fetchActiveDocument(for:and:)``
/// - ``createDocument(with:)``
///
public struct ChecklistService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.checklistBaseURLs)
    
    public init() {}
    
    /// Answers a checklist item with the provided details.
    /// - Parameter answerCheckListItemEntity: An entity containing the answer details for a checklist item.
    /// - Returns: A publisher emitting `ResultData<RFTestParameters>` upon success or a `NetworkRequestError` on failure.
    public func answerChecklistItem(with answerCheckListItemEntity: DRAnswerCheckListItemEntity) ->
    AnyPublisher<ResultData<RFTestParameters>, NetworkRequestError> {
        
        let request = AnswerCheckListItemPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            answerCheckListItemEntity: answerCheckListItemEntity
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of commercial places with quantity of available and finished checklists.
    /// - Returns: A publisher emitting `ResultDataList<ComPlaceWithData>` containing the list of commercial places or a `NetworkRequestError` on failure.
    public func fetchComPlaceList() ->
    AnyPublisher<ResultDataList<ComPlaceWithData>, NetworkRequestError> {
        
        let request = PlaceListGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of checklists for a specified commercial place.
    /// - Parameter idComPlace: The identifier of the commercial place for which the checklist list is requested.
    /// - Returns: A publisher emitting `ResultDataList<RFCheckViewModel>` containing the list of checklists or a `NetworkRequestError` on failure.
    public func fetchChecklistList(for idComPlace: String) ->
    AnyPublisher<ResultDataList<RFCheckViewModel>, NetworkRequestError> {
        
        let request = CheckListForPlaceGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idComPlace: idComPlace
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of documents for a specified commercial place, filtered and sorted according to the given criteria.
    /// - Parameters:
    ///   - idComPlace: The identifier of the commercial place for which documents are being requested.
    ///   - filter: A `FilterAndSort` object specifying how the returned list should be filtered and sorted.
    /// - Returns: A publisher emitting `ResultDataList<DHCheckPerformedFullDataViewModel>` upon success, or a `NetworkRequestError` on failure.
    public func fetchDocumentList(for idComPlace: String, with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DocumentListForPlacePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idComPlace: idComPlace,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves a list of checklist items that have been performed, associated with document identifier.
    /// - Parameter idDH: The identifier of the DH for which performed checklist items are being requested.
    /// - Returns: A publisher emitting `ResultDataList<DRCheckListItemForDHPerformedViewModel>` upon success, or a `NetworkRequestError` on failure.
    ///
    /// This operation is particularly useful for auditing or compliance purposes, allowing for a comprehensive review of all actions taken on a particular document handler's checklist.
    public func fetchCheckPerformedItems(for idDH: String) ->
    AnyPublisher<ResultDataList<DRCheckListItemForDHPerformedViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedItemListGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDH
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of performed checklists filtered and sorted according to the provided criteria.
    /// - Parameter filter: A `FilterAndSort` object specifying the criteria for filtering and sorting the returned list.
    /// - Returns: A publisher emitting `ResultDataList<DHCheckPerformedFullDataViewModel>` upon success, or a `NetworkRequestError` on failure.
    ///
    /// Enables the retrieval of a comprehensive list of checklists that have been completed, facilitating the management and review process based on specific filtering and sorting requirements.
    public func fetchPerformedChecklistList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves checklist items based on a specific checklist reference and filter criteria.
    /// - Parameters:
    ///   - filter: A `FilterAndSort` object for filtering and sorting the checklist items.
    ///   - idRFCheck: The identifier of the checklist reference.
    /// - Returns: A publisher emitting `ResultDataList<DRCheckListItemForDHPerformedViewModel>` upon success, or a `NetworkRequestError` on failure.
    public func fetchChecklistItems(with filter: FilterAndSort, idRFCheck: String) ->
    AnyPublisher<ResultDataList<DRCheckListItemForDHPerformedViewModel>, NetworkRequestError> {
        
        let request = RFCheckItemListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idRFCheck: idRFCheck,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Completes a checklist, marking it as finished with an optional comment.
    /// - Parameters:
    ///   - idDHCheckPerformed: The identifier of the checklist being marked as finished.
    ///   - comment: An optional comment about the checklist completion.
    /// - Returns: A publisher emitting `ResultData<DHCheckPerformedFullDataViewModel>` upon success, or a `NetworkRequestError` on failure.
    public func finishCheck(for idDHCheckPerformed: String, with comment: String) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedFinishPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDHCheckPerformed,
            comment: comment
        )
        return apiClient.dispatch(request)
    }
    
    /// Sends a report of a completed checklist to a designated email.
    /// - Parameter idDHCheckPerformed: The identifier of the completed checklist for which the report is being sent.
    /// - Returns: A publisher emitting `ResultData<EmptyResultOperation>` upon successful report dispatch, or a `NetworkRequestError` on failure.
    ///
    /// This method facilitates the automated dissemination of checklist completion reports, enhancing communication and record-keeping practices.
    ///
    ///  E-mail could be set with `SCRMService`.
    public func sendReportToEmail(for idDHCheckPerformed: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = DHCheckPerformedReportPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDHCheckPerformed
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches the active document associated with a given commercial place and checklist.
    /// - Parameters:
    ///   - idrfComPlace: The identifier of the commercial place.
    ///   - idrfCheck: The identifier of the checklist.
    /// - Returns: A publisher emitting `ResultData<DHCheckPerformedFullDataViewModel>` upon success, or a `NetworkRequestError` on failure.
    public func fetchActiveDocument(for idrfComPlace: String, and idrfCheck: String) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedActiveGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfComPlace: idrfComPlace,
            idrfCheck: idrfCheck
        )
        return apiClient.dispatch(request)
    }
    
    /// Creates a new document based on the provided checklist entity.
    /// - Parameter checkEntity: A `DHCheckPerformedEntityCreate` object containing the details for the new document.
    /// - Returns: A publisher emitting `ResultData<DHCheckPerformedFullDataViewModel>` upon success, or a `NetworkRequestError` on failure.
    public func createDocument(with checkEntity: DHCheckPerformedEntityCreate) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            checkEntity: checkEntity
        )
        return apiClient.dispatch(request)
    }
}
