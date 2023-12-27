//
//  ComPlaceListPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 15.12.2023.
//

import Foundation

struct ComPlaceListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RFComPlaceViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/complace/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { filter }
}
