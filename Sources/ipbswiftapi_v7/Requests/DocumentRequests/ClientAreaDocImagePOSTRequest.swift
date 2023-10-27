//
//  ClientAreaDocImagePOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Foundation

struct ClientAreaDocImagePOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFCharacteristicValueViewModel>
    
    let accessToken: String
    let idCharVal: String
    let image: MediaModel
    
    var path: String { "/clientarea/doc/image/" + idCharVal }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var media: [MediaModel]? { [image] }
}
