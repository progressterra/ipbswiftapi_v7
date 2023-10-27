//
//  CatalogItemModel.swift
//  
//
//  Created by Artemy Volkov on 07.07.2023.
//

import Foundation

// MARK: - CatalogItem model
public struct CatalogItem: Codable {
    public let itemCategory: RFCatalogCategoryViewModel
    public let listChildItems: [CatalogItem]?
}

public enum TypeDisplayCategoryCatalog: String, Codable {
    case displaying = "displaying"
    case notDisplaying = "notDisplaying"
}

public enum TypeFormatViewProduct: String, Codable {
    case wideFormat = "wideFormat"
    case towInLine = "towInline"
}
