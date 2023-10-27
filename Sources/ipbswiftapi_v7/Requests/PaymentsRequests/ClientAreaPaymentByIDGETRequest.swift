//
//  ClientAreaPaymentByIDGETRequest.swift
//  
//
//  Created by Artemy Volkov on 17.08.2023.
//

struct ClientAreaPaymentByIDGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHPaymentClientViewModel>
    
    let accessToken: String
    let idUnique: String
    
    var path: String { "/clientarea/payment/" + idUnique }
    var token: String? { accessToken }
    var method: HTTPMethod { .get }
    var contentType: String? { nil }
}
