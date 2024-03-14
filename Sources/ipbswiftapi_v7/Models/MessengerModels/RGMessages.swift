//
//  RGMessages.swift
//
//
//  Created by Artemy Volkov on 14.03.2024.
//

import Foundation

public struct RGMessages: Codable {
    public let idDialog: String
    public var contentText: String?
    public let idQuotedMessage: String?
    public let idClient: String
    public let dataClientJSONData: String?
    public let quotedMessageJSONData: String?
    public let dateRead: Date?
    public let agileListReactionData: String?
    public let idLastRRGHistory: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    
    public init(
        idDialog: String,
        contentText: String?,
        idQuotedMessage: String?,
        idClient: String,
        dataClientJSONData: String?,
        quotedMessageJSONData: String?,
        dateRead: Date?,
        agileListReactionData: String?,
        idLastRRGHistory: String?,
        idUnique: String,
        idEnterprise: String,
        dateAdded: Date,
        dateUpdated: Date,
        dateSoftRemoved: Date?
    ) {
        self.idDialog = idDialog
        self.contentText = contentText
        self.idQuotedMessage = idQuotedMessage
        self.idClient = idClient
        self.dataClientJSONData = dataClientJSONData
        self.quotedMessageJSONData = quotedMessageJSONData
        self.dateRead = dateRead
        self.agileListReactionData = agileListReactionData
        self.idLastRRGHistory = idLastRRGHistory
        self.idUnique = idUnique
        self.idEnterprise = idEnterprise
        self.dateAdded = dateAdded
        self.dateUpdated = dateUpdated
        self.dateSoftRemoved = dateSoftRemoved
    }
}
