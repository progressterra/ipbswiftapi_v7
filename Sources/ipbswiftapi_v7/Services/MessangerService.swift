//
//  MessengerService.swift
//
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Combine

/// Manages messaging functionalities such as dialog creation, message sending, and retrieval.
///
/// `MessengerService` uses an `APIClient` to interact with messaging-related endpoints as configured in `IPBSettings.messengerBaseURLs`. It supports creating new dialogs, sending and retrieving messages, listing dialogs based on filters, searching for dialogs, and updating messages.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Messaging Operations
///
/// - ``createDialog(with:)``
/// - ``getDialogList(with:)``
/// - ``sendMessage(with:)``
/// - ``getMessageList(with:)``
/// - ``searchDialog(with:)``
/// - ``patchMessage(with:)``
///
public struct MessengerService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.messengerBaseURLs)
    
    public init() {}
    
    /// Creates a new dialog with the given income data.
    /// - Parameter incomeData: The data needed to create a new dialog.
    /// - Returns: A publisher that emits `ResultData<RGDialogsViewModel>` upon success or a `NetworkRequestError` on failure.
    public func createDialog(with incomeData: IncomeDataForCreateDialog) ->
    AnyPublisher<ResultData<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            incomeData: incomeData
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves a list of dialogs based on the specified filter and sort criteria.
    /// - Parameter filter: The filtering and sorting criteria for the dialogs to be retrieved.
    /// - Returns: A publisher that emits `ResultDataList<RGDialogsViewModel>` containing the list of dialogs or a `NetworkRequestError` on failure.
    public func getDialogList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Sends a message with the specified message creation entity.
    /// - Parameter messagesEntityCreate: The entity containing the data required to send a message.
    /// - Returns: A publisher that emits `ResultData<RGMessagesViewModel>` upon success or a `NetworkRequestError` on failure.
    public func sendMessage(with messagesEntityCreate: RGMessagesEntityCreate) ->
    AnyPublisher<ResultData<RGMessagesViewModel>, NetworkRequestError> {
        
        let request = ClientAreaMessagePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            messagesEntityCreate: messagesEntityCreate
        )
        return apiClient.dispatch(request)
    }
    
    /// Retrieves a list of messages based on the specified filter and sort criteria.
    /// - Parameter filter: The filtering and sorting criteria for the messages to be retrieved.
    /// - Returns: A publisher that emits `ResultDataList<RGMessagesViewModel>` containing the list of messages or a `NetworkRequestError` on failure.
    public func getMessageList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RGMessagesViewModel>, NetworkRequestError> {
        
        let request = ClientAreaMessageListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Searches for dialogs matching the given search data.
    /// - Parameter searchData: The data used to search for dialogs.
    /// - Returns: A publisher that emits `ResultData<RGDialogsViewModel>` for the found dialog or a `NetworkRequestError` on failure.
    public func searchDialog(with searchData: IncomeDataSearchDialog) ->
    AnyPublisher<ResultData<RGDialogsViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDialogSearchPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            searchDialogData: searchData
        )
        return apiClient.dispatch(request)
    }
    
    /// Updates a message with the given message entity.
    /// - Parameter message: The message entity containing the new data for the message.
    /// - Returns: A publisher that emits `ResultData<RGMessagesViewModel>` upon success or a `NetworkRequestError` on failure.
    public func patchMessage(with message: RGMessages) ->
    AnyPublisher<ResultData<RGMessagesViewModel>, NetworkRequestError> {
        
        let request = MessagePATCHRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            message: message
        )
        return apiClient.dispatch(request)
    }
}
