//
//  DocumentService.swift
//
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Combine


/// Manages document-related operations, including fetching, creating, and updating documents.
///
/// `DocumentService` leverages an `APIClient` to make network requests to document-related endpoints as configured in `IPBSettings`. It offers functionalities for handling document characteristics, creating new documents, setting data or images for documents, and fetching documents based on specified criteria.
///
/// ## Topics
///
/// ### Initialization
///
/// - ``init()``
///
/// ### Document Operations
///
/// - ``fetchCharacteristicType(for:)``
/// - ``createDocument(for:)``
/// - ``setData(for:with:)``
/// - ``setImage(for:with:)``
/// - ``fetchDocumentList(with:)``
/// - ``fetchDocSet(for:)``
///
public struct DocumentService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.documentsBaseURLs)
    
    public init() {}
    
    /// Fetches the characteristic type for a specified entity.
    /// - Parameter idEntity: The identifier of the entity for which the characteristic type is requested.
    /// - Returns: A publisher emitting `ResultData<RFCharacteristicTypeViewModel>` upon success or a `NetworkRequestError` on failure.
    public func fetchCharacteristicType(for idEntity: String) ->
    AnyPublisher<ResultData<RFCharacteristicTypeViewModel>, NetworkRequestError> {
        
        let request = CharacteristicTypeGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idEntity: idEntity
        )
        return apiClient.dispatch(request)
    }
    
    /// Creates a document for a specified characteristic type.
    /// - Parameter idrfCharacteristicType: The identifier of the characteristic type for which the document is created.
    /// - Returns: A publisher emitting `ResultData<RFCharacteristicValueViewModel>` upon successful document creation or a `NetworkRequestError` on failure.
    public func createDocument(for idrfCharacteristicType: String) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfCharacteristicType: idrfCharacteristicType
        )
        return apiClient.dispatch(request)
    }
    
    /// Sets data for a specified characteristic value.
    /// - Parameters:
    ///   - idCharVal: The identifier of the characteristic value to be updated.
    ///   - value: The new value for the characteristic.
    /// - Returns: A publisher emitting `ResultData<RFCharacteristicValueViewModel>` upon successful update or a `NetworkRequestError` on failure.
    public func setData(for idCharVal: String, with value: String) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocDataPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCharVal: idCharVal,
            bodyValue: value
        )
        return apiClient.dispatch(request)
    }
    
    /// Sets an image for a specified characteristic value.
    /// - Parameters:
    ///   - idCharVal: The identifier of the characteristic value to be updated.
    ///   - image: A `MediaModel` containing the image to be set.
    ///     Prefer to use default MediaModel initialization.
    /// - Returns: A publisher emitting `ResultData<RFCharacteristicValueViewModel>` upon successful image update or a `NetworkRequestError` on failure.
    public func setImage(for idCharVal: String, with image: MediaModel) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocImagePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCharVal: idCharVal,
            image: image
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a list of documents based on the provided filter and sort criteria.
    /// - Parameter filter: A `FilterAndSort` object specifying the filtering and sorting criteria for the documents to be retrieved.
    /// - Returns: A publisher emitting `ResultDataList<RFCharacteristicValueViewModel>` containing the list of documents or a `NetworkRequestError` on failure.
    public func fetchDocumentList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    /// Fetches a document set for a specified specification.
    /// - Parameter idSpecification: The identifier of the specification for which the document set is requested.
    /// - Returns: A publisher emitting `ResultData<DHDocSetFullData>` upon successful retrieval or a `NetworkRequestError` on failure.
    public func fetchDocSet(for idSpecification: String) ->
    AnyPublisher<ResultData<DHDocSetFullData>, NetworkRequestError> {
        
        let request = ClientAreaDocSetSpecPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idSpecification: idSpecification
        )
        return apiClient.dispatch(request)
    }
}
