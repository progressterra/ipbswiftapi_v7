//
//  RGClientChannel.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

import Foundation

public struct RGClientChannel: Codable {
    public let idClient: String
    public let typeChannel: TypeChannelEnum
    public let dataChannel: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let dateBlocked: String?
    public let dateConfirm: String?
}
