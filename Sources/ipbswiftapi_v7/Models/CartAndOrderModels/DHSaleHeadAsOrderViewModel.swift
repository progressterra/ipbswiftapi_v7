//
//  DHSaleHeadAsOrderViewModel.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Foundation

// MARK: - DHSaleHeadAsOrderViewModel
public struct DHSaleHeadAsOrderViewModel: Codable {
    public let statusOrder: TypeStatusOrder?
    public let number: String?
    public let numberInt: Int
    public let typeSaleReturn: TypeSaleReturn?
    public let idrfShop: String
    public let idClient: String?
    public let adressString: String?
    public let idExtDataAddress: String?
    public let datePosted: Date?
    public let iddhPreSale: String?
    public let idrfCashier: String?
    public let beginTimeService: String?
    public let endTimeService: String?
    public let datePostedAddBonuses: String?
    public let datePostedWritingBonuses: String?
    public let dateSync: String?
    public let dateSyncWithExternalERP: String?
    public let idrgCashChange: String
    public let currentPositionInCashCahnge: Int?
    public let fiscalCheckNumber: Int?
    public let fDocumentNumber: Int
    public let fiscalCheckFN: String?
    public let fiscalCheckFD: String?
    public let fiscalCheckFP: String?
    public let dateToSend: Date?
    public let dateConfirm: Date?
    public let dateCollection: Date?
    public let dateTranssferToSend: Date?
    public let dateStartProcessingDelivery: Date?
    public let dateCustomerReceived: Date?
    public let dateClose: Date?
    public let idEmployyeOrderPicker: String?
    public let idEmployyeCourier: String?
    public let idExternalERP: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let listDRSale: [DRSaleForCartAndOrder]?
    public let listDRComment: [DRComment]?
}

// MARK: - DHSaleHeadAsOrderViewModel Enums
public enum TypeStatusOrder: String, Codable, CaseIterable {
    case oneClick = "oneClick"
    case cart = "cart"
    case order = "order"
    case confirmFromStore = "confirmFromStore"
    case confirmFromCallCenter = "confirmFromCallCenter"
    case sentToWarehouse = "sentToWarehouse"
    case sentDeliveryService = "sentDeliveryService"
    case onPickUpPoint = "onPickUpPoint"
    case delivered = "delivered"
    case canceled = "canceled"
}

public enum TypeSaleReturn: String, Codable {
    case sale = "sale"
    case returnSale = "returnSale"
    case correct = "correct"
    case marketiing = "marketiing"
}
