//
//  IncomeDataSearchDialog.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

public struct IncomeDataSearchDialog: Codable {
    public let listIDClients: [String]?
    
    public init(listIDClients: [String]?) {
        self.listIDClients = listIDClients
    }
}
