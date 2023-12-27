//
//  DHCheckPerformedFullDataViewModel.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

import Foundation

public struct DHCheckPerformedFullDataViewModel: Codable, Hashable {
    public let idrfCheck: String
    public let idBase: String?
    public let idrfComPlace: String?
    public let dateStart: Date?
    public let targetGeoPoint: String?
    public let geoPoint: String?
    public let idClient: String
    public let finalComments: String?
    public let dateEnd: Date?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let nameComPlace: String?
    public let nameRFCheck: String?
    public let countDR: Int
    public let countDRPositiveAnswer: Int
    public let countDRNegativeAnswer: Int
}
