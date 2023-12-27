//
//  DHCheckPerformedPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedPOSTRequest: Request {
    typealias Parameters = DHCheckPerformedEntityCreate
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHCheckPerformedFullDataViewModel>
    
    let accessToken: String
    let checkEntity: DHCheckPerformedEntityCreate
    
    var path: String { "/dhcheckperformed" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: DHCheckPerformedEntityCreate? { checkEntity }
}
