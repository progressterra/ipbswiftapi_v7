//
//  RFPaymentDataForClientViewModel.swift
//  
//
//  Created by Artemy Volkov on 16.08.2023.
//

import Foundation

public struct RFPaymentDataForClientViewModel: Codable {
    public let idClient: String
    public let paymentDataType: TypePaymentData
    public let preiview: String?
    public let hashGeneralData: String?
    public let hashFullData: String?
    public let paymentSystemName: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}

public enum TypePaymentData: String, Codable {
    case bankcardData = "bankcardData"
    case bankCardAccount = "bankCardAccount"
}
