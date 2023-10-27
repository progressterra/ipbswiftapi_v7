//
//  EndLoginRequest.swift
//  
//
//  Created by Artemy Volkov on 09.07.2023.
//

struct EndLoginRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ResultAuthAsJWT>
    
    let tempToken: String
    let codeFromSMS: String
    
    var path: String { "/clientchannel/login/end" }
    var method: HTTPMethod { .post }
    var body: Parameters? { ["tempToken": tempToken, "codeFromSMS": codeFromSMS] }
}
