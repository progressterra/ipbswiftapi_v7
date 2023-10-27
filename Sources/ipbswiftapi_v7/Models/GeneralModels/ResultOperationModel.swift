//
//  ResultOperationModel.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Foundation

// MARK: - ResultOperation model
public struct ResultOperation: Codable {
    public var status: StatusResult
    public var message: String?
    public var messageDev: String?
    public var codeResult: Int
    public var duration: Double
    public var idLog: String
    public var xRequestID: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case messageDev = "messageDev"
        case codeResult = "codeResult"
        case duration = "duration"
        case idLog = "idLog"
        case xRequestID = "x-request-id"
    }
}

// MARK: - Enum for status
public enum StatusResult: String, Codable {
    case success = "success"
    case warning = "warning"
    case errorServer = "errorServer"
    case errorAuth = "errorAuth"
    case errorAccess = "errorAccess"
}
