//
//  DHCheckPerformedListPOSTRequest.swift
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DHCheckPerformedFullDataViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/dhcheckperformed/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
