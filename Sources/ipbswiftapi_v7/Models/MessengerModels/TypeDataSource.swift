//
//  TypeDataSource.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

public enum TypeDataSource: String, Codable {
    case custom = "custom"
    case enterprise = "enterprise"
    case client = "client"
    case order = "order"
    case docset = "docset"
    case iwantit = "iwantit"
}
