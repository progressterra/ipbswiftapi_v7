//
//  RFTestParameters.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct RFTestParameters: Codable {
    public let idrfCheck: String?
    public let indexName: String?
    public let internalName: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
}
