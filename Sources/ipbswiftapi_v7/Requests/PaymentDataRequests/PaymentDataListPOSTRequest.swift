//
//  PaymentDataListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 16.08.2023.
//

struct PaymentDataListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RFPaymentDataForClientViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/clientarea/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
