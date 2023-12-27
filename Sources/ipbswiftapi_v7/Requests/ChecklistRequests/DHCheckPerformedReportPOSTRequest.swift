//
//  DHCheckPerformedReportPOSTRequest.swift
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedReportPOSTRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<EmptyResultOperation>
    
    let accessToken: String
    let idDHCheckPerformed: String
    
    var path: String { "/dhcheckperformed/\(idDHCheckPerformed)/report" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
}
