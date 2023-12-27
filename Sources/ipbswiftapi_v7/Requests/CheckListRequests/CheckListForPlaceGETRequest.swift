//
//  CheckListForPlaceGETRequest.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

struct CheckListForPlaceGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RFCheckViewModel>
    
    let accessToken: String
    let idComPlace: String
    
    var path: String { "/place/\(idComPlace)/rfcheck/list" }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
