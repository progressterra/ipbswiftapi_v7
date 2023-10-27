//
//  RFCharacteristicTypeViewModel.swift
//  
//
//  Created by Artemy Volkov on 26.07.2023.
//

import Foundation

public struct RFCharacteristicTypeViewModel: Codable {
    public let name: String?
    public let comment: String?
    public let order: Int?
    public let typeValue: TypeValueCharacteristic?
    public let dataInJSON: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}

public enum TypeValueCharacteristic: String, Codable {
    case asString = "asString"
    case asNumber = "asNumber"
    case asDateTime = "asDateTime"
    case asReference = "asReference"
    case asCustomASJSON = "asCustomASJSON"
}
