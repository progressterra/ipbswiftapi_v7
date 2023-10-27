//
//  CartSalerowDELETERequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

import Foundation

struct CartSalerowDELETERequest: Request {
    struct Parameters: Encodable {
        let idrfNomenclature: String
        let count: Int
    }
    
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let body: Parameters?
    
    var path: String { "/cart/salerow" }
    var method: HTTPMethod { .delete }
    var token: String? { accessToken }
    
    init(accessToken: String, idrfNomenclature: String, count: Int) {
        self.accessToken = accessToken
        self.body = Parameters(idrfNomenclature: idrfNomenclature, count: count)
    }
}
