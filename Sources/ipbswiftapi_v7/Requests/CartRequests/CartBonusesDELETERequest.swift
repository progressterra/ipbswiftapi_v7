//
//  CartBonusesDELETERequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct CartBonusesDELETERequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    
    var path: String { "/cart/bonuses" }
    var method: HTTPMethod { .delete }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
