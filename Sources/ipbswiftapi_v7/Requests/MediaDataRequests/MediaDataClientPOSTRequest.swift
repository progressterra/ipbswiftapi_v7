//
//  MediaDataClientPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 24.08.2023.
//

import Foundation

struct MediaDataClientPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias ReturnType = ResultData<RGEntityMediaDataViewModel>
    
    struct QueryParameters: Encodable {
        let typeContent: TypeContent
        let alias: String
        let tag: Int
    }
    
    let accessToken: String
    let typeContent: TypeContent
    let alias: String
    let tag: Int
    let medias: [MediaModel]
    
    var path: String { "/mediadata/client" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var queryParameters: QueryParameters? {
        QueryParameters(
            typeContent: typeContent,
            alias: alias,
            tag: tag
        )
    }
    var media: [MediaModel]? { medias }
}
