//
//  LogoutAllTokensRequest.swift
//  
//
//  Created by Artemy Volkov on 09.07.2023.
//

struct LogoutAllTokensRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<EmptyResultOperation>
    
    let userId: String
    let accessToken: String
    
    var path: String { "/token/logout/all" }
    var method: HTTPMethod { .post }
    var body: Parameters? { ["idUser": userId] }
    var token: String? { accessToken }
}
