//
//  DHCheckPerformedEntityCreate.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

import Foundation

public struct DHCheckPerformedEntityCreate: Codable {
    public let idrfCheck: String
    public let idBase: String?
    public let idrfComPlace: String
    public let dateStart: Date
    public let targetGeoPoint: String?
    public let geoPoint: String?
    
    public init(idrfCheck: String, idBase: String?, idrfComPlace: String, dateStart: Date, targetGeoPoint: String?, geoPoint: String?) {
        self.idrfCheck = idrfCheck
        self.idBase = idBase
        self.idrfComPlace = idrfComPlace
        self.dateStart = dateStart
        self.targetGeoPoint = targetGeoPoint
        self.geoPoint = geoPoint
    }
}
