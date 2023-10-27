//
//  IPBSettings.swift
// 
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Foundation

public struct IPBSettings {
    
    public static let emptyGuid = "00000000-0000-0000-0000-000000000000"
    
    public private(set) static var imageCompressionQuality = 1.0
    
    public private(set) static var accessKeyEnterprise = ""
    
    public private(set) static var clientLoginBaseURL = ""
    public private(set) static var catalogBaseURL = ""
    public private(set) static var productBaseURL = ""
    public private(set) static var cartBaseURL = ""
    public private(set) static var documentsBaseURL = ""
    public private(set) static var messengerBaseURL = ""
    public private(set) static var paymentDataBaseURL = ""
    public private(set) static var paymentsBaseURL = ""
    public private(set) static var balanceRegisterBaseURL = ""
    public private(set) static var sCRMBaseURL = ""
    public private(set) static var mediaDataBaseURL = ""
    
    public private(set) static var wantThisDocumentID = ""
    public private(set) static var bankCardDocumentID = ""
    
    public private(set) static var ruPassportID = ""
    public private(set) static var ByKzKgAmPassportID = ""
    public private(set) static var TgUzUaPassportID = ""
    
    public private(set) static var topSalesCategoryID = ""
    public private(set) static var promoProductsCategoryID = ""
    public private(set) static var newProductsCategoryID = ""
    
    public private(set) static var techSupportID = ""
    public private(set) static var ordersSupportID = ""
    public private(set) static var wantThisSupportID = ""
    public private(set) static var documentsSupportID = ""
    
    public private(set) static var authDescription = ""
    
    // MARK: - DaData
    public private(set) static var daDataBaseURL = ""
    public private(set) static var daDataAPIKey = ""
    
    private struct IPBSettingsConfiguration: Codable {
        let imageCompressionQuality: Double
        
        let accessKeyEnterprise: String
        let clientLoginBaseURL: String
        let catalogBaseURL: String
        let productBaseURL: String
        let cartBaseURL: String
        let documentsBaseURL: String
        let messengerBaseURL: String
        let paymentDataBaseURL: String
        let paymentsBaseURL: String
        let balanceRegisterBaseURL: String
        let sCRMBaseURL: String
        let mediaDataBaseURL: String
        
        let wantThisDocumentID: String
        let bankCardDocumentID: String
        
        let ruPassportID: String
        let ByKzKgAmPassportID: String
        let TgUzUaPassportID: String
        
        let topSalesCategoryID: String
        let promoProductsCategoryID: String
        let newProductsCategoryID: String
        
        let techSupportID: String
        let ordersSupportID: String
        let wantThisSupportID: String
        let documentsSupportID: String
        
        let authDescription: String
        
        // DaData
        let daDataBaseURL: String
        let daDataAPIKey: String
    }
        
    public static func loadConfiguration() {
        let decoder = JSONDecoder()
        
        guard let url = Bundle.main.url(forResource: "IPBSettingsConfig", withExtension: "json") else {
            fatalError("Failed to locate IPBSettingsConfig.json file.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load IPBSettingsConfig.json file.")
        }
        
        do {
            let config = try decoder.decode(IPBSettingsConfiguration.self, from: data)
            configure(with: config)
        } catch {
            fatalError("Failed to decode IPBSettingsConfig.json file: \(error.localizedDescription)")
        }
    }
    
    private static func configure(with config: IPBSettingsConfiguration) {
        imageCompressionQuality = config.imageCompressionQuality
        
        accessKeyEnterprise = config.accessKeyEnterprise
        clientLoginBaseURL = config.clientLoginBaseURL
        catalogBaseURL = config.catalogBaseURL
        productBaseURL = config.productBaseURL
        cartBaseURL = config.cartBaseURL
        documentsBaseURL = config.documentsBaseURL
        messengerBaseURL = config.messengerBaseURL
        paymentDataBaseURL = config.paymentDataBaseURL
        paymentsBaseURL = config.paymentsBaseURL
        balanceRegisterBaseURL = config.balanceRegisterBaseURL
        sCRMBaseURL = config.sCRMBaseURL
        mediaDataBaseURL = config.mediaDataBaseURL
        
        wantThisDocumentID = config.wantThisDocumentID
        bankCardDocumentID = config.bankCardDocumentID
        
        ruPassportID = config.ruPassportID
        ByKzKgAmPassportID = config.ByKzKgAmPassportID
        TgUzUaPassportID = config.TgUzUaPassportID
        
        topSalesCategoryID = config.topSalesCategoryID
        promoProductsCategoryID = config.promoProductsCategoryID
        newProductsCategoryID = config.newProductsCategoryID
        
        techSupportID = config.techSupportID
        ordersSupportID = config.ordersSupportID
        wantThisSupportID = config.wantThisSupportID
        documentsSupportID = config.documentsSupportID
        
        authDescription = config.authDescription
        
        daDataBaseURL = config.daDataBaseURL
        daDataAPIKey = config.daDataAPIKey
    }
}
