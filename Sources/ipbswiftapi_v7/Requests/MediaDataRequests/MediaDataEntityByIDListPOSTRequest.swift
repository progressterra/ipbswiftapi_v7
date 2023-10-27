//
//  MediaDataEntityByIDListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 24.08.2023.
//

import Foundation

struct MediaDataEntityByIDListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RGEntityMediaDataViewModel>
    
    let accessToken: String
    let idEntity: String
    let filter: FilterAndSort
    
    var path: String { "/mediadata/entity/\(idEntity)/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
