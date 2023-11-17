//
//  DocumentService.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Combine

public struct DocumentService {
    
    private let apiClient = APIClient(baseURLs: IPBSettings.documentsBaseURLs)
    
    public init() {}
    
    public func fetchCharacteristicType(for idEntity: String) ->
    AnyPublisher<ResultData<RFCharacteristicTypeViewModel>, NetworkRequestError> {
        
        let request = CharacteristicTypeGETRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idEntity: idEntity
        )
        return apiClient.dispatch(request)
    }
    
    public func createDocument(for idrfCharacteristicType: String) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idrfCharacteristicType: idrfCharacteristicType
        )
        return apiClient.dispatch(request)
    }
    
    public func setData(for idCharVal: String, with value: String) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocDataPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCharVal: idCharVal,
            bodyValue: value
        )
        return apiClient.dispatch(request)
    }
    
    public func setImage(for idCharVal: String, with image: MediaModel) ->
    AnyPublisher<ResultData<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocImagePOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idCharVal: idCharVal,
            image: image
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchDocumentList(with filter: FilterAndSort) ->
    AnyPublisher<ResultDataList<RFCharacteristicValueViewModel>, NetworkRequestError> {
        
        let request = ClientAreaDocListPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            filter: filter
        )
        return apiClient.dispatch(request)
    }
    
    public func fetchDocSet(for idSpecification: String) ->
    AnyPublisher<ResultData<DHDocSetFullData>, NetworkRequestError> {
        
        let request = ClientAreaDocSetSpecPOSTRequest(
            accessToken: AuthStorage.shared.getAccessToken(),
            idSpecification: idSpecification
        )
        return apiClient.dispatch(request)
    }
}
