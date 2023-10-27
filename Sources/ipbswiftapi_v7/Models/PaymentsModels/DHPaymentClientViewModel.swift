//
//  DHPaymentClientViewModel.swift
//  
//
//  Created by Artemy Volkov on 16.08.2023.
//

import Foundation

import Foundation

public struct DHPaymentClientViewModel: Codable {
    public let idPaymentData: String
    public let amount: Double
    public let status: TypeResultOperationBusinessArea
    public let previewPaymentMethod: String?
    public let errorDescription: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}

public enum TypeResultOperationBusinessArea: String, Codable {
    case inProgress = "in_progress"
    case success = "success"
    case withError = "withError"
}
