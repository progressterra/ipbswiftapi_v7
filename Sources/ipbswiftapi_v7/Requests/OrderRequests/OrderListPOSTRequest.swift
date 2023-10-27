//
//  OrderListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct OrderListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/order/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { filter }
}
