//
//  RGMoveDataEntityAmount.swift
//  
//
//  Created by Artemy Volkov on 18.08.2023.
//

import Foundation

public struct RGMoveDataEntityAmount: Codable {
    public let idrfRegister: String
    public let dimension1: String?
    public let dimension2: String?
    public let dimension3: String?
    public let dimension4: String?
    public let dimension5: String?
    public let amount: Double
}
