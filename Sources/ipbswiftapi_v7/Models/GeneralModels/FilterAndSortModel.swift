//
//  FilterAndSort.swift
//  
//
//  Created by Artemy Volkov on 07.07.2023.
//

import Foundation

// MARK: - Filter And Sort
public struct FilterAndSort: Codable {
    public let listFields: [FieldForFilter]?
    public let sort: SortData?
    public let searchData: String?
    public let skip: Int
    public let take: Int
    
    public init(listFields: [FieldForFilter]?, sort: SortData?, searchData: String?, skip: Int, take: Int) {
        self.listFields = listFields
        self.sort = sort
        self.searchData = searchData
        self.skip = skip
        self.take = take
    }
}

public struct FieldForFilter: Codable {
    public let fieldName: String?
    public let listValue: [String]?
    public let comparison: TypeComparison?
    
    public init(fieldName: String?, listValue: [String]?, comparison: TypeComparison?) {
        self.fieldName = fieldName
        self.listValue = listValue
        self.comparison = comparison
    }
}

public struct SortData: Codable {
    public let fieldName: String?
    public let variantSort: TypeVariantSort
    
    public init(fieldName: String?, variantSort: TypeVariantSort) {
        self.fieldName = fieldName
        self.variantSort = variantSort
    }
}

public enum TypeComparison: String, Codable, Hashable {
    case equalsStrong
    case equalsIgnoreCase
    case containsStrong
    case containsIgnoreCase
}

public enum TypeVariantSort: String, Codable, Hashable {
    case asc
    case desc
}
