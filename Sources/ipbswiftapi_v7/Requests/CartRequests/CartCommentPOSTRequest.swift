//
//  CartCommentPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 12.07.2023.
//

struct CartCommentPOSTRequest: Request {
    typealias Parameters = [String: String]
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<DHSaleHeadAsOrderViewModel>
    
    let accessToken: String
    let comment: String
    
    var path: String { "/cart/comment" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { ["dataComment": comment] }
}
