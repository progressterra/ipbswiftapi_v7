//
//  ClientAreaPATCHRequest.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

struct ClientAreaPATCHRequest: Request {
    typealias Parameters = ClientsEntity
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ClientsViewModel>
    
    let accessToken: String
    let clientsEntity: ClientsEntity
    
    var path: String { "/clientarea" }
    var method: HTTPMethod { .patch }
    var token: String? { accessToken }
    var body: ClientsEntity? { clientsEntity }
}
