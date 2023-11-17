//
//  MessengerService.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Combine

public struct MessengerService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.messengerBaseURLs)
    
    public init() {}
    
    public func createDialog(with incomeData: IncomeDataForCreateDialog) ->
    AnyPublisher<ResultData<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            incomeData: incomeData
        )
        return apiClient.dispatch(request)
    }
    
    public func getDialogList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func sendMessage(with messagesEntityCreate: RGMessagesEntityCreate) ->
    AnyPublisher<ResultData<RGMessagesViewModel>, NetworkRequestError> {
        
        let request = ClientAreaMessagePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            messagesEntityCreate: messagesEntityCreate
        )
        return apiClient.dispatch(request)
    }
    
    public func getMessageList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGMessagesViewModel>, NetworkRequestError> {
        
        let request = ClientAreaMessageListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func searchDialog(with searchData: IncomeDataSearchDialog) ->
    AnyPublisher<ResultData<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogSearchPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            searchDialogData: searchData
        )
        return apiClient.dispatch(request)
    }
}
