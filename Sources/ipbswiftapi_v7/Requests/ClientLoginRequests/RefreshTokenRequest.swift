//
//  RefreshTokenRequest.swift
//  
//
//  Created by Artemy Volkov on 09.07.2023.
//

struct RefreshTokenRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ResultAuthAsJWT>
    
    let refreshToken: String
    
    var path: String { "/token/refresh" }
    var method: HTTPMethod { .post }
    var token: String? { refreshToken }
}
