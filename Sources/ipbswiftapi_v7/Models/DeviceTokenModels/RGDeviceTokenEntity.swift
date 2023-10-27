//
//  RGDeviceTokenEntity.swift
//  
//
//  Created by Artemy Volkov on 18.09.2023.
//

public struct RGDeviceTokenEntity: Codable {
    let osType: TypeOS
    let tokenData: String?
    
    public init(osType: TypeOS = .ios, tokenData: String? = nil) {
        self.osType = osType
        self.tokenData = tokenData
    }
}

public enum TypeOS: String, Codable {
    case ios = "ios"
    case android = "android"
}
