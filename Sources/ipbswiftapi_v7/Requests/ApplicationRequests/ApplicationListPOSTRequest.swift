//
//  ApplicationListPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.03.2024.
//

struct ApplicationListPOSTRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<RGApplicationViewModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/application/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
