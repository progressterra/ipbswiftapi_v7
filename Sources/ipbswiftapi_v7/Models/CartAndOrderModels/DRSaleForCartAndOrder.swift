//
//  DRSaleForCartAndOrder.swift
//  
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

// MARK: - DRSaleForCartAndOrder
public struct DRSaleForCartAndOrder: Codable {
    public let iddhSaleHead: String
    public let nameGoods: String?
    public let idrfNomenclature: String
    public let numberInstallmentMonths: Int
    public let quantity: Int
    public let amountBasePrice: Double
    public let amountBeginPrice: Double
    public let amountEndPrice: Double
    public let amountDiscount: Double
    public let amountBonusDiscount: Double
    public let amountBonusAdded: Double
}
