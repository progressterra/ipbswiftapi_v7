//
//  CartAddressPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct CartAddressPOSTRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let addressString: String
    let idAddress: String
    
    var path: String { "/cart/address" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? {
        ["addressString": addressString, "idAddress": idAddress]
    }
}
