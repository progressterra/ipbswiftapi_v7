//
//  ClientAreaGETRequest.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

struct ClientAreaGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ClientsViewModel>
    
    let accessToken: String
    
    var path: String { "/clientarea" }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
