//
//  ClientsViewModel.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

import Foundation

public struct ClientsViewModel: Codable {
    public let name: String?
    public let soname: String?
    public let patronymic: String?
    public let sex: TypeSex
    public let dateOfBirth: String?
    public let dateOfRegister: String?
    public let comment: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String?
    public let dateUpdated: String?
    public let dateSoftRemoved: String?
    public let dateBlocked: String?
    public let additionalInfo: String?
    public let eMailGeneral: String?
    public let phoneGeneral: String?
}
