//
//  RGDeviceTokenViewModel.swift
//  
//
//  Created by Artemy Volkov on 18.09.2023.
//

public struct RGDeviceTokenViewModel: Codable {
    public let osType: TypeOS
    public let tokenData: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let idClient: String
}
