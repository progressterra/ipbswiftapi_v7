//
//  RFSpecification.swift
//  
//
//  Created by Artemy Volkov on 03.08.2023.
//

import Foundation

public struct RFSpecification: Codable {
    public let name: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}
