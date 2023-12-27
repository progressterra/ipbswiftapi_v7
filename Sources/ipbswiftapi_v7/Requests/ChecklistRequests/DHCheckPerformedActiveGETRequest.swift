//
//  DHCheckPerformedActiveGETRequest.swift
//
//
//  Created by Artemy Volkov on 19.12.2023.
//

struct DHCheckPerformedActiveGETRequest: Request {
    typealias Parameters = [String: String]?
    typealias ReturnType = ResultData<DHCheckPerformedFullDataViewModel>
    
    struct QueryParameters: Encodable {
        let idrfComPlace: String
        let idrfCheck: String
    }
    
    let accessToken: String
    let idrfComPlace: String
    let idrfCheck: String
    
    var path: String { "/dhcheckperformed/active" }
    var token: String? { accessToken }
    var contentType: String? { nil }
    var queryParameters: QueryParameters? {
        QueryParameters(
            idrfComPlace: idrfComPlace,
            idrfCheck: idrfCheck
        )
    }
}
