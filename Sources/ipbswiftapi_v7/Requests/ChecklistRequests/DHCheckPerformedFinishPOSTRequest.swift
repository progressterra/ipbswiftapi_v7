//
//  DHCheckPerformedFinishPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedFinishPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHCheckPerformedFullDataViewModel>
    
    let accessToken: String
    let idDHCheckPerformed: String
    let comment: String
    
    var path: String { "/dhcheckperformed/finish/" + idDHCheckPerformed }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { ["data": comment] }
}
