//
//  ClientAreaDocDataPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Foundation

struct ClientAreaDocDataPOSTRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFCharacteristicValueViewModel>
    
    let accessToken: String
    let idCharVal: String
    let bodyValue: String
    
    var path: String { "/clientarea/doc/data/" + idCharVal }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters?  {
        ["data": bodyValue]
    }
}
