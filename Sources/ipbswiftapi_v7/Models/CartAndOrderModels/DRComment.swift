//
//  DRComment.swift
//  
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

// MARK: - DRComment
public struct DRComment: Codable {
    public let iddhSaleHead: String
    public let comment: String?
    public let messageForClient: String?
    public let isInternal: Bool
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}
