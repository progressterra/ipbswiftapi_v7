//
//  LogutTokenRequest.swift
//  
//
//  Created by Artemy Volkov on 09.07.2023.
//

struct LogoutTokenRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<EmptyResultOperation>
    
    let refreshToken: String
    let accessToken: String
    
    var path: String { "/token/logout" }
    var method: HTTPMethod { .post }
    var body: Parameters? { ["jwtRefreshToken": refreshToken] }
    var token: String? { accessToken }
}
