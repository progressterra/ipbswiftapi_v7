//
//  RFCheckViewModel.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct RFCheckViewModel: Codable {
    public let language: String?
    public let name: String?
    public let description: String?
    public let urlImage: String?
    public let urlVideo: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
}
