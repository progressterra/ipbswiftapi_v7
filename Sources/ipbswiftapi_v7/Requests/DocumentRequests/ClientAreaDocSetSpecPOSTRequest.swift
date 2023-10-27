//
//  ClientAreaDocSetSpecPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 03.08.2023.
//

import Foundation

struct ClientAreaDocSetSpecPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHDocSetFullData>
    
    let accessToken: String
    let idSpecification: String
    
    var path: String { "/clientarea/docset/spec/" + idSpecification }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
}
