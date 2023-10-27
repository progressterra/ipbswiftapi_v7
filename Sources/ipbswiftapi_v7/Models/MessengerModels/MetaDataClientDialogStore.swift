//
//  MetaDataClientDialogStore.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

public struct MetaDataClientDialogStore: Codable {
    public let dataSourceType: TypeDataSource
    public let dataSourceName: String?
    public let description: String?
    public let listImages: [RGEntityMediaDataViewModel]?
}
