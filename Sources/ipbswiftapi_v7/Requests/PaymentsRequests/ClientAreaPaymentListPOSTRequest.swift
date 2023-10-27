//
//  ClientAreaPaymentListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 17.08.2023.
//

struct ClientAreaPaymentListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DHPaymentClientViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/clientarea/payment/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
