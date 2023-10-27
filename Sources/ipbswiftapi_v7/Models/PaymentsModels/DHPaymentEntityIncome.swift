//
//  DHPaymentEntityIncome.swift
//  
//
//  Created by Artemy Volkov on 17.08.2023.
//

public struct DHPaymentEntityIncome: Codable {
    public let idPaymentData: String
    public let amount: Double
    
    public init(idPaymentData: String, amount: Double) {
        self.idPaymentData = idPaymentData
        self.amount = amount
    }
}
