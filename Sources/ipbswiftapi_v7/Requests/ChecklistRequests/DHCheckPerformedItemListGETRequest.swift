//
//  DHCheckPerformedItemListGETRequest.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedItemListGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<DRCheckListItemForDHPerformedViewModel>
    
    let accessToken: String
    let idDHCheckPerformed: String
    
    var path: String { "/dhcheckperformed/item/\(idDHCheckPerformed)/list"}
    var token: String? { accessToken }
    var contentType: String? { nil }
}
