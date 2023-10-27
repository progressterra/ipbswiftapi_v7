//
//  ClientAreaPaymentPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 17.08.2023.
//

struct ClientAreaPaymentPOSTRequest: Request {
    typealias Parameters = DHPaymentEntityIncome
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHPaymentClientViewModel>
    
    let accessToken: String
    let paymentEntity: DHPaymentEntityIncome
    
    var path: String { "/clientarea/payment" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: DHPaymentEntityIncome? { paymentEntity }
}
