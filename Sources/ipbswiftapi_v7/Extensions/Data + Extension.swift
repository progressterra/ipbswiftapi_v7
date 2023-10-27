//
//  Data + Extension.swift
//  
//
//  Created by Artemy Volkov on 02.08.2023.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
