//
//  MediaDataDELETEByIDRequest.swift
//
//
//  Created by Artemy Volkov on 25.12.2023.
//

struct MediaDataDELETEByIDRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<EmptyResultOperation>
    
    let accessToken: String
    let idMediaEntity: String
    
    var path: String { "/mediadata/\(idMediaEntity)" }
    var method: HTTPMethod { .delete }
    var token: String? { accessToken }
}
