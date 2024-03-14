//
//  ApplicationPATCHRequest.swift
//
//
//  Created by Artemy Volkov on 13.03.2024.
//

struct ApplicationPATCHRequest: Request {
    typealias Parameters = RGApplicationViewModel
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGApplicationViewModel>
    
    let accessToken: String
    let applicationEntity: RGApplicationViewModel
    
    var path: String { "/application" }
    var method: HTTPMethod { .patch }
    var token: String? { accessToken }
    var body: RGApplicationViewModel? { applicationEntity }
}
