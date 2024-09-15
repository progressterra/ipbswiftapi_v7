//
//  File.swift
//  
//
//  Created by Sergey Spevak on 16.09.2024.
//

struct ClientAreaDELETERequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<EmptyResultOperation>
    
    let accessToken: String
    
    var path: String { "/clientarea" }
    var method: HTTPMethod { .delete }
    var token: String? { accessToken }
}

