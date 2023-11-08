//
//  MetaDataClientWithID.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

public struct MetaDataClientWithID: Codable {
    public let dataSourceType: TypeDataSource
    public let dataSourceName: String?
    public let description: String?
    public let listImages: [RGEntityMediaDataViewModel]?
    public let idClient: String
    
    public init(dataSourceType: TypeDataSource, dataSourceName: String?, description: String?, listImages: [RGEntityMediaDataViewModel]?, idClient: String) {
        self.dataSourceType = dataSourceType
        self.dataSourceName = dataSourceName
        self.description = description
        self.listImages = listImages
        self.idClient = idClient
    }
}
