//
//  RFCityViewModel.swift
//
//
//  Created by Artemy Volkov on 15.12.2023.
//

import Foundation

public struct RFCityViewModel: Codable {
    public let name: String?
    public let latitudeCenter: Double
    public let longitudeCenter: Double
    public let radius: Int
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
}
