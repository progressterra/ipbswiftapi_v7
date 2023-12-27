//
//  ClientAreaEmailPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct ClientAreaEmailPOSTRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGClientChannel>
    
    let accessToken: String
    let email: String
    
    var path: String { "/clientarea/email" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { ["data": email] }
}
