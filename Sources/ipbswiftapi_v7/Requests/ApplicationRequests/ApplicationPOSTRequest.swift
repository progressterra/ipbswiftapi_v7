//
//  ApplicationPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.03.2024.
//

struct ApplicationPOSTRequest: Request {
    typealias Parameters = RGApplicationEntityCore
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGApplicationViewModel>
    
    let accessToken: String
    let applicationEntity: RGApplicationEntityCore
    
    var path: String { "/application" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: RGApplicationEntityCore? { applicationEntity }
}
