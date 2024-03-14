//
//  RGApplicationViewModel.swift
//
//
//  Created by Artemy Volkov on 12.03.2024.
//

import Foundation

public struct RGApplicationViewModel: Codable {
    public let idProduct: String
    public let nameClient: String?
    public let sonameClient: String?
    public let phoneNumber: String?
    public let email: String?
    public let idTelegram: String?
    public let idChannel: String?
    public let nameOfChannel: String?
    public let message: String?
    public let idClient: String?
    public let idOrder: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    
    public init(idProduct: String, nameClient: String?, sonameClient: String?, phoneNumber: String?, email: String?, idTelegram: String?, idChannel: String?, nameOfChannel: String?, message: String?, idClient: String?, idOrder: String?, idUnique: String, idEnterprise: String, dateAdded: Date, dateUpdated: Date, dateSoftRemoved: Date?) {
        self.idProduct = idProduct
        self.nameClient = nameClient
        self.sonameClient = sonameClient
        self.phoneNumber = phoneNumber
        self.email = email
        self.idTelegram = idTelegram
        self.idChannel = idChannel
        self.nameOfChannel = nameOfChannel
        self.message = message
        self.idClient = idClient
        self.idOrder = idOrder
        self.idUnique = idUnique
        self.idEnterprise = idEnterprise
        self.dateAdded = dateAdded
        self.dateUpdated = dateUpdated
        self.dateSoftRemoved = dateSoftRemoved
    }
}
