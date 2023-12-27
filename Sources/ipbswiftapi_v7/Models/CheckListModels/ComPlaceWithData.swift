//
//  ComPlaceWithData.swift
//  
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct ComPlaceWithData: Codable {
    public let shopType: TypeComPlace
    public let name: String?
    public let address: String?
    public let dateOpen: Date?
    public let dateClose: Date?
    public let idrfCtiy: String
    public let contacts: String?
    public let latitude: Double
    public let longitude: Double
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let city: RFCityViewModel
    public let listImages: [RGEntityMediaDataViewModel]?
    public let countAvailableRFCheck: Int
    public let countDHCheckPerformedForExecution: Int
}
