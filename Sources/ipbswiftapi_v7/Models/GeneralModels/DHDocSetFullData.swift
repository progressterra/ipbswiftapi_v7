//
//  DHDocSetFullData.swift
//  
//
//  Created by Artemy Volkov on 03.08.2023.
//

import Foundation

public struct DHDocSetFullData: Codable {
    public let idSpecification: String
    public let idClient: String
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateSoftRemoved: String?
    public let specification: RFSpecification
    public let listProductCharacteristic: [CharacteristicData]?
}
