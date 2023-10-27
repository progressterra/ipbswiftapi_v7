//
//  ResultSendCodeForClient.swift
//  
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

public struct ResultSendCodeForClient: Codable {
    public let tempToken: String?
    public let secondForResendSMS: Int
    public let numberAttemptsLeft: Int
}
