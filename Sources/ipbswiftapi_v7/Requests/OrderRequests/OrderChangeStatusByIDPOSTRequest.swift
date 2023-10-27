//
//  OrderChangeStatusByIDPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 31.08.2023.
//

struct OrderChangeStatusByIDPOSTRequest: Request {
    typealias Parameters = [String: TypeStatusOrder]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let idOrder: String
    let statusType: TypeStatusOrder
    
    var path: String { "/order/\(idOrder)/status" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? {
        ["newStatus": statusType]
    }
}
