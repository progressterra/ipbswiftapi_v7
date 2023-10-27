//
//  CartBonusesPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct CartBonusesPOSTRequest: Request {
    typealias Parameters = [String: Double]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let amountBonuses: Double
    
    var path: String { "/cart/bonuses" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { ["amountBonuses": amountBonuses] }
}
