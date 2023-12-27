//
//  PlaceListGETRequest.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

struct PlaceListGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<ComPlaceWithData>
    
    let accessToken: String
    
    var path: String { "/place/list" }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
