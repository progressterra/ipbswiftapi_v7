//
//  RGDialogsClientsViewModel.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

public struct RGDialogsClientsViewModel: Codable {
    public let idrgDialog: String
    public let idClient: String
    public let dateLastMessages: Date
    public let dateLastRead: Date
    public let idLastReadMessages: String
    public let metaDataClientJSON: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let clientMetaData: MetaDataClientDialogStore
}
