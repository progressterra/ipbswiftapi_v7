//
//  ClientAreaDocListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 27.07.2023.
//

import Foundation

struct ClientAreaDocListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RFCharacteristicValueViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/clientarea/doc/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
