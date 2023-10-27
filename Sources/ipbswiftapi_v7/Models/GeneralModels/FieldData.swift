//
//  FieldData.swift
//  
//
//  Created by Artemy Volkov on 26.07.2023.
//

import Foundation

public struct FieldData: Codable {
    public init(idrfCharacteristicType: String, name: String?, comment: String?, order: Int, typeValue: TypeValueCharacteristic, valueData: String?) {
        self.idrfCharacteristicType = idrfCharacteristicType
        self.name = name
        self.comment = comment
        self.order = order
        self.typeValue = typeValue
        self.valueData = valueData
    }
    
    public var idrfCharacteristicType: String
    public var name: String?
    public var comment: String?
    public var order: Int
    public var typeValue: TypeValueCharacteristic
    public var valueData: String?
}
