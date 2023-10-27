//
//  CharacteristicTypeGETRequest.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Foundation

struct CharacteristicTypeGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFCharacteristicTypeViewModel>
    
    let accessToken: String
    let idEntity: String
    
    var path: String { "/characteristic/type/" + idEntity }
    var method: HTTPMethod { .get }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
