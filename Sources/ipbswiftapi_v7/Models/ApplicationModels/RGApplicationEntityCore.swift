//
//  RGApplicationEntityCore.swift
//
//
//  Created by Artemy Volkov on 12.03.2024.
//

import Foundation

public struct RGApplicationEntityCore: Codable {
    public let idProduct: String
    public let nameClient: String?
    public let sonameClient: String?
    public let phoneNumber: String?
    public let email: String?
    public let idTelegram: String?
    public let idChannel: String?
    public let nameOfChannel: String?
    public let message: String?
    
    public init(idProduct: String, nameClient: String?, sonameClient: String?, phoneNumber: String?, email: String?, idTelegram: String?, idChannel: String?, nameOfChannel: String?, message: String?) {
        self.idProduct = idProduct
        self.nameClient = nameClient
        self.sonameClient = sonameClient
        self.phoneNumber = phoneNumber
        self.email = email
        self.idTelegram = idTelegram
        self.idChannel = idChannel
        self.nameOfChannel = nameOfChannel
        self.message = message
    }
}
