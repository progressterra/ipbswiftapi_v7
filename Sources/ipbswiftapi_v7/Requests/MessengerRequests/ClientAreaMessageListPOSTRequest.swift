//
//  ClientAreaMessageListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

struct ClientAreaMessageListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RGMessagesViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/clientarea/message/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
