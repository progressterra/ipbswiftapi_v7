//
//  RFCharacteristicValueViewModel.swift
//  
//
//  Created by Artemy Volkov on 26.07.2023.
//

import Foundation

public struct RFCharacteristicValueViewModel: Codable {
    public let idrfCharacteristicType: String
    public let idClient: String?
    public let statusDoc: TypeStatusDoc?
    public let idManagerCalculation: String?
    public let dateCalculation: String?
    public let reasonReject: String?
    public let valueAsString: String?
    public let valueAsNumber: Double?
    public let valueAsDate: String?
    public let valueAsReference: String?
    public let valueAsJSON: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let viewData: String?
    public let listImages: [RGEntityMediaDataViewModel]?
    public let characteristicType: RFCharacteristicTypeViewModel
}

public enum TypeStatusDoc: String, Codable {
    case notFill = "notFill"
    case waitImage = "waitImage"
    case waitReview = "waitReview"
    case rejected = "rejected"
    case confirmed = "confirmed"
}
