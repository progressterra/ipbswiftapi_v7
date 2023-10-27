//
//  OrderByIDGETRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct OrderByIDGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let idOrder: String
    
    var path: String { "/order/" + idOrder }
    var method: HTTPMethod { .get }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
