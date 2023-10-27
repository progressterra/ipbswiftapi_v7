//
//  ClientAreaDocPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Foundation

struct ClientAreaDocPOSTRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFCharacteristicValueViewModel>
    
    let accessToken: String
    let idrfCharacteristicType: String
    
    var path: String { "/clientarea/doc" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters?  {
        ["idrfCharacteristicType": idrfCharacteristicType]
    }
}
