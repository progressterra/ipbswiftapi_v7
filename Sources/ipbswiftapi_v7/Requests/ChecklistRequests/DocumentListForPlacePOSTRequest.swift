//
//  DocumentListForPlacePOSTRequest.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

struct DocumentListForPlacePOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DHCheckPerformedFullDataViewModel>
    
    let accessToken: String
    let idComPlace: String
    let filter: FilterAndSort
    
    var path: String { "/place/\(idComPlace)/dhcheckperformed/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
