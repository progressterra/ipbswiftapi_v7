//
//  RGDialogsViewModel.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

public struct RGDialogsViewModel: Codable {
    public let description: String?
    public let additionalDataJSON: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let listMetaDataClient: [RGDialogsClientsViewModel]?
}
