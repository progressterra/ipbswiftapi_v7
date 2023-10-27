//
//  RGMessagesEntityCreate.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

public struct RGMessagesEntityCreate: Codable {
    public let idDialog: String
    public let contentText: String?
    public let idQuotedMessage: String?
    
    public init(idDialog: String, contentText: String?, idQuotedMessage: String?) {
        self.idDialog = idDialog
        self.contentText = contentText
        self.idQuotedMessage = idQuotedMessage
    }
}
