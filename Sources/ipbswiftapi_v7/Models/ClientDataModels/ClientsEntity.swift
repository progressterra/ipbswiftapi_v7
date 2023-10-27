//
//  ClientsEntity.swift
//  
//
//  Created by Artemy Volkov on 22.08.2023.
//

import Foundation

public struct ClientsEntity: Codable {
    public let name: String?
    public let soname: String?
    public let patronymic: String?
    public let sex: TypeSex
    public let dateOfBirth: String?
    public let dateOfRegister: String
    public let comment: String?
    
    public init(
        name: String?,
        soname: String?,
        patronymic: String?,
        sex: TypeSex,
        dateOfBirth: String?,
        dateOfRegister: String,
        comment: String?
    ) {
        self.name = name
        self.soname = soname
        self.patronymic = patronymic
        self.sex = sex
        self.dateOfBirth = dateOfBirth
        self.dateOfRegister = dateOfRegister
        self.comment = comment
    }
}
