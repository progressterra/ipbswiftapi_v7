//
//  CharacteristicData.swift
//  
//
//  Created by Artemy Volkov on 03.08.2023.
//

import Foundation

public struct CharacteristicData: Codable {
    public let characteristicType: RFCharacteristicTypeViewModel
    public let characteristicValue: RFCharacteristicValueViewModel
    public let isMandatory: Bool?
    public let imageRequired: Bool?
}
