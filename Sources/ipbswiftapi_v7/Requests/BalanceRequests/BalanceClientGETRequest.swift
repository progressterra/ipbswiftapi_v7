//
//  BalanceClientGETRequest.swift
//  
//
//  Created by Artemy Volkov on 18.08.2023.
//

struct BalanceClientGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGMoveDataEntityAmount>
    
    let accessToken: String
    
    var path: String { "/balance/client" }
    var method: HTTPMethod { .get }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
