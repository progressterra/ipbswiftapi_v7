//
//  StartLoginRequest.swift
//  
//
//  Created by Artemy Volkov on 08.07.2023.
//

struct StartLoginRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ResultSendCodeForClient>

    let phone: String
    let accessKeyEnterprise: String

    var path: String { "/clientchannel/login/start" }
    var method: HTTPMethod { .post }
    var body: Parameters? {
        ["phone": phone, "accessKeyEnterprise": accessKeyEnterprise]
    }
}
