//
//  RFCatalogCategoryViewModel.swift
//  
//
//  Created by Artemy Volkov on 09.08.2023.
//

import Foundation

public struct RFCatalogCategoryViewModel: Codable, Hashable {
    public static func == (lhs: RFCatalogCategoryViewModel, rhs: RFCatalogCategoryViewModel) -> Bool {
        lhs.idUnique == rhs.idUnique
    }
    
    public let idParentCategory: String?
    public let displayingType: TypeDisplayCategoryCatalog
    public let formatViewProductType: TypeFormatViewProduct
    public let name: String?
    public let description: String?
    public let imageDataInJSON: String?
    public let order: Int
    public let extID: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: String
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let imageData: RGEntityMediaDataViewModel?
}
