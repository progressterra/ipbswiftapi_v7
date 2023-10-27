//
//  MediaDataEntityPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 24.08.2023.
//

import Foundation

struct MediaDataEntityPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias ReturnType = ResultData<RGEntityMediaDataViewModel>
    
    struct QueryParameters: Encodable {
        let idEntity: String
        let typeContent: TypeContent
        let entityTypeName: String
        let alias: String
        let tag: Int
    }
    
    let accessToken: String
    let idEntity: String
    let typeContent: TypeContent
    let entityTypeName: String
    let alias: String
    let tag: Int
    let medias: [MediaModel]
    
    var path: String { "/mediadata/entity" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var queryParameters: QueryParameters? {
        QueryParameters(
            idEntity: idEntity,
            typeContent: typeContent,
            entityTypeName: entityTypeName,
            alias: alias,
            tag: tag
        )
    }
    var media: [MediaModel]? { medias }
}
