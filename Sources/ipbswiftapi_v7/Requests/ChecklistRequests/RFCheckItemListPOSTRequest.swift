//
//  RFCheckItemListPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 22.12.2023.
//

struct RFCheckItemListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DRCheckListItemForDHPerformedViewModel>
    
    let accessToken: String
    let idRFCheck: String
    let filter: FilterAndSort
    
    var path: String { "/rfcheck/\(idRFCheck)/item/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
