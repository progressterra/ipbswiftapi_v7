//
//  MessagePATCHRequest.swift
//
//
//  Created by Artemy Volkov on 14.03.2024.
//

struct MessagePATCHRequest: Request {
    typealias Parameters = RGMessages
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGMessagesViewModel>
    
    let accessToken: String
    let message: RGMessages
    
    var path: String { "/message" }
    var method: HTTPMethod { .patch }
    var token: String? { accessToken }
    var body: RGMessages? { message }
}
