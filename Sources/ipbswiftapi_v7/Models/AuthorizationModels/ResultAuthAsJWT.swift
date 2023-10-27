//
//  ResultAuthAsJWT.swift
//
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Foundation

public struct ResultAuthAsJWT: Codable {
    public let refreshToken: String?
    public let accessToken: String?
    public let needChangePassword: Bool
}
