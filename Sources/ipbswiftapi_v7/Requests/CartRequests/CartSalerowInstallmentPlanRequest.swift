//
//  CartSalerowInstallmentPlanRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

import Foundation

struct CartSalerowInstallmentPlanRequest: Request {
    struct Parameters: Encodable {
        let idrfNomenclature: String
        let count: Int
        let countMonthPayment: Int
        let amountPaymentInMonth: Double
    }
    
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let body: Parameters?
    
    var path: String { "/cart/salerow/installmentplan" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    
    init(accessToken: String, idrfNomenclature: String, count: Int, countMonthPayment: Int, amountPaymentInMonth: Double) {
        self.accessToken = accessToken
        self.body = Parameters(idrfNomenclature: idrfNomenclature, count: count, countMonthPayment: countMonthPayment, amountPaymentInMonth: amountPaymentInMonth)
    }
}
