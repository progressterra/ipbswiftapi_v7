//
//  CartRequest.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

struct CartRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    
    var path: String { "/cart" }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
