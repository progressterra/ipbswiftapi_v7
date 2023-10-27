//
//  ProductViewDataModel.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Foundation

public struct ProductViewDataModel: Codable {
    public let nomenclature: RFNomenclatureViewModel
    public let inventoryData: RGGoodsInventoryViewModel
    public let listProductCharacteristic: [CharacteristicData]?
    public let installmentPlanValue: InstallmentPlan
    public let countInCart: Int
}

public struct RFNomenclatureViewModel: Codable {
    public let idrfSpecification: String
    public let name: String?
    public let commerseDescription: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let listCatalogCategory: [String]?
    public let listImages: [RGEntityMediaDataViewModel]?
    public let popularOrder: Int
    public let rating: Double
}

public struct RGGoodsInventoryViewModel: Codable {
    public let idrfNomenclatura: String
    public let idrfComPlace: String
    public let quantity: Int
    public let idDiscountBasisForBeginPrice: String?
    public let beginPrice: Double
    public let currentPrice: Double
    public let minPrice: Double
    public let maxValueDiscount: Double
    public let defectName: String?
    public let idExternalSystem: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
}

public struct InstallmentPlan: Codable {
    public let countMonthPayment: Int
    public let amountPaymentInMonth: Double
}
