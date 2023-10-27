//
//  CartInternalPaymentPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct CartInternalPaymentPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    
    var path: String { "/cart/internalpayment" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
