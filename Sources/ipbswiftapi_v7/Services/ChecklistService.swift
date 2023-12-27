//
//  ChecklistService.swift
//
//  Created by Artemy Volkov on 19.12.2023.
//

import Combine

public struct ChecklistService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.checklistBaseURLs)
    
    public init() {}
    
    public func answerChecklistItem(with answerCheckListItemEntity: DRAnswerCheckListItemEntity) ->
    AnyPublisher<ResultData<RFTestParameters>, NetworkRequestError> {
        
        let request = AnswerCheckListItemPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            answerCheckListItemEntity: answerCheckListItemEntity
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchComPlaceList() ->
    AnyPublisher<ResultDataList<ComPlaceWithData>, NetworkRequestError> {
        
        let request = PlaceListGETRequest(
            accessToken: AuthStorage.shared.getAccessToken()
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchChecklistList(for idComPlace: String) ->
    AnyPublisher<ResultDataList<RFCheckViewModel>, NetworkRequestError> {
        
        let request = CheckListForPlaceGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idComPlace: idComPlace
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchDocumentList(for idComPlace: String, with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DocumentListForPlacePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idComPlace: idComPlace,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchCheckPerformedItems(for idDH: String) ->
    AnyPublisher<ResultDataList<DRCheckListItemForDHPerformedViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedItemListGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDH
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchPerformedChecklistList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchChecklistItems(with filter: FilterAndSort, idRFCheck: String) ->
    AnyPublisher<ResultDataList<DRCheckListItemForDHPerformedViewModel>, NetworkRequestError> {
        
        let request = RFCheckItemListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idRFCheck: idRFCheck,
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func finishCheck(for idDHCheckPerformed: String, with comment: String) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedFinishPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDHCheckPerformed,
            comment: comment
        )
        return apiClient.dispatch(request)
    }
    
    public func sendReportToEmail(for idDHCheckPerformed: String) ->
    AnyPublisher<ResultData<EmptyResultOperation>, NetworkRequestError> {
        
        let request = DHCheckPerformedReportPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idDHCheckPerformed: idDHCheckPerformed
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchActiveDocument(for idrfComPlace: String, and idrfCheck: String) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedActiveGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfComPlace: idrfComPlace,
            idrfCheck: idrfCheck
        )
        return apiClient.dispatch(request)
    }
    
    public func createDocument(with checkEntity: DHCheckPerformedEntityCreate) ->
    AnyPublisher<ResultData<DHCheckPerformedFullDataViewModel>, NetworkRequestError> {
        
        let request = DHCheckPerformedPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            checkEntity: checkEntity
        )
        return apiClient.dispatch(request)
    }
}
