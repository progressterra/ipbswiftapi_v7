//
//  IncomeDataForCreateDialog.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

public struct IncomeDataForCreateDialog: Codable {
    public let listClients: [MetaDataClientWithID]?
    public let description: String?
    public let additionalDataJSON: String?
    
    public init(listClients: [MetaDataClientWithID]?, description: String?, additionalDataJSON: String?) {
        self.listClients = listClients
        self.description = description
        self.additionalDataJSON = additionalDataJSON
    }
}
