//
//  IPBSettings.swift
//
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Foundation

/// `IPBSettings` manages the configuration settings for the application.
///
/// This struct loads and stores configuration settings from `IPBSettingConfig.json`. These settings include API base URLs, logging preferences, document IDs, and more, essential for the application's network layer configuration.
///
/// To utilize these settings, create a file named `IPBSettingConfig.json` in your project with the structure provided below, replacing placeholders with actual values.
///
/// ## Configuration File Structure
///
/// Create a `IPBSettingConfig.json` file with the following content, adapting it to your specific needs:
///
///
/**
 ```json
 {
    "isLoggingEnabled": true ,
    "imageCompressionQuality": 1.0,
    "accessKeyEnterprise": "[your access key]",
    "accessTokenForUnauthorizedUser": "[your access token]",
    "applicationBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."]
    "clientLoginBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "catalogBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "productBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "cartBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "documentsBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "messengerBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "paymentDataBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "paymentsBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "balanceRegisterBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "sCRMBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "mediaDataBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "comPlaceBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "checklistBaseURLs": ["[primary base URL]", "[secondary base URL]", "..."],
    "wantThisDocumentID": "[document ID]",
    "bankCardDocumentID": "[document ID]",
    "ruPassportID": "[document ID]",
    "ByKzKgAmPassportID": "[document ID]",
    "TgUzUaPassportID": "[document ID]",
    "topSalesCategoryID": "[category ID]",
    "promoProductsCategoryID": "[category ID]",
    "newProductsCategoryID": "[category ID]",
    "techSupportID": "[support ID]",
    "ordersSupportID": "[support ID]",
    "wantThisSupportID": "[support ID]",
    "documentsSupportID": "[support ID]",
    "authDescription": "[authorization description]",
    "daDataBaseURL": "https://suggestions.dadata.ru/suggestions/api/4_1/rs",
    "daDataAPIKey": "[DaData API key]"
 }
 ```
 */
///
/// ### Loading the Configuration
///
/// Call `IPBSettings.loadConfiguration()` at the application's launch to load these settings. This is typically done in the `AppDelegate` or the SwiftUI `App` struct's initialization phase.
///
/// ```swift
/// IPBSettings.loadConfiguration()
/// ```
///
/// ## Topics
///
/// ### Configuration Loading
///
/// - ``loadConfiguration()``
public struct IPBSettings {
    
    public private(set) static var isLoggingEnabled: Bool = false
    
    public static let emptyGuid = "00000000-0000-0000-0000-000000000000"
    
    public private(set) static var imageCompressionQuality = 1.0
    
    public private(set) static var accessKeyEnterprise = ""
    public private(set) static var accessTokenForUnauthorizedUser = ""
    
    public private(set) static var applicationBaseURLs = [""]
    public private(set) static var clientLoginBaseURLs = [""]
    public private(set) static var catalogBaseURLs = [""]
    public private(set) static var productBaseURLs = [""]
    public private(set) static var cartBaseURLs = [""]
    public private(set) static var documentsBaseURLs = [""]
    public private(set) static var messengerBaseURLs = [""]
    public private(set) static var paymentDataBaseURLs = [""]
    public private(set) static var paymentsBaseURLs = [""]
    public private(set) static var balanceRegisterBaseURLs = [""]
    public private(set) static var sCRMBaseURLs = [""]
    public private(set) static var mediaDataBaseURLs = [""]
    public private(set) static var comPlaceBaseURLs = [""]
    public private(set) static var checklistBaseURLs = [""]
    
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
        let isLoggingEnabled: Bool
        let imageCompressionQuality: Double
        
        let accessTokenForUnauthorizedUser: String
        let accessKeyEnterprise: String
        
        let applicationBaseURLs: [String]
        let clientLoginBaseURLs: [String]
        let catalogBaseURLs: [String]
        let productBaseURLs: [String]
        let cartBaseURLs: [String]
        let documentsBaseURLs: [String]
        let messengerBaseURLs: [String]
        let paymentDataBaseURLs: [String]
        let paymentsBaseURLs: [String]
        let balanceRegisterBaseURLs: [String]
        let sCRMBaseURLs: [String]
        let mediaDataBaseURLs: [String]
        let comPlaceBaseURLs: [String]
        let checklistBaseURLs: [String]
        
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
    
    /// Loads the application configuration settings from `IPBSettingConfig.json`.
    ///
    /// This method reads the configuration file, decodes its content, and applies the settings globally within `IPBSettings`. It must be called during the application's initialization process.
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
            fatalError("Failed to decode IPBSettingsConfig.json file: \(error)")
        }
    }
    
    private static func configure(with config: IPBSettingsConfiguration) {
        isLoggingEnabled = config.isLoggingEnabled
        imageCompressionQuality = config.imageCompressionQuality
        
        accessKeyEnterprise = config.accessKeyEnterprise
        accessTokenForUnauthorizedUser = config.accessTokenForUnauthorizedUser
        
        applicationBaseURLs = config.applicationBaseURLs
        clientLoginBaseURLs = config.clientLoginBaseURLs
        catalogBaseURLs = config.catalogBaseURLs
        productBaseURLs = config.productBaseURLs
        cartBaseURLs = config.cartBaseURLs
        documentsBaseURLs = config.documentsBaseURLs
        messengerBaseURLs = config.messengerBaseURLs
        paymentDataBaseURLs = config.paymentDataBaseURLs
        paymentsBaseURLs = config.paymentsBaseURLs
        balanceRegisterBaseURLs = config.balanceRegisterBaseURLs
        sCRMBaseURLs = config.sCRMBaseURLs
        mediaDataBaseURLs = config.mediaDataBaseURLs
        comPlaceBaseURLs = config.comPlaceBaseURLs
        checklistBaseURLs = config.checklistBaseURLs
        
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
