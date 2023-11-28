//
//  RGEntityMediaDataViewModel.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Foundation

public struct RGEntityMediaDataViewModel: Codable, Hashable {
    public static func == (lhs: RGEntityMediaDataViewModel, rhs: RGEntityMediaDataViewModel) -> Bool {
        lhs.idUnique == rhs.idUnique
    }
    
    public let idEntity: String
    public let entityTypeName: String?
    public let privateForClientID: String?
    public let urlData: String?
    public let stringData: String?
    public let dataJSON: String?
    public let alias: String?
    public let previewText: String?
    public let order: Int
    public let tag: Int
    public let contentType: TypeContent
    public let size: Int
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: String
    public let dateSoftRemoved: String?
    public let listInfoImageWrapper: ListInfoImageWrapper?
    
    enum CodingKeys: String, CodingKey {
        case idEntity
        case entityTypeName
        case privateForClientID
        case urlData
        case stringData
        case dataJSON
        case alias
        case previewText
        case order
        case tag
        case contentType
        case size
        case idUnique
        case idEnterprise
        case dateAdded
        case dateUpdated
        case dateSoftRemoved
        case listInfoImageWrapper = "listInfoImage"
    }
}

public struct ListInfoImageWrapper: Codable, Hashable {
    public let listInfoImage: [InfoImage]?
}

public struct InfoImage: Codable, Hashable {
    public let url: String?
    public let sizeType: TypeSize
    public let width: Int
    public let height: Int
    public let size: Int
}

public enum TypeContent: String, Codable {
    case image = "image"
    case video = "video"
    case pdf = "pdf"
    case html = "html"
    case htmlString = "htmlString"
    case stringData = "stringData"
    case voiceData = "voiceData"
}

public enum TypeSize: String, Codable {
    case large = "large"
    case medium = "medium"
    case original = "original"
    case small = "small"
}
