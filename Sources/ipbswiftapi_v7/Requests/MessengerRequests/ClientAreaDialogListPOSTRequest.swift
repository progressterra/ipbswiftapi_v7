//
//  ClientAreaDialogListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

struct ClientAreaDialogListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RGDialogsViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/clientarea/dialog/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
