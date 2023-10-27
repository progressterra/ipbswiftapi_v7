//
//  ClientAreaMessagePOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

struct ClientAreaMessagePOSTRequest: Request {
    typealias Parameters = RGMessagesEntityCreate
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGMessagesViewModel>
    
    let accessToken: String
    let messagesEntityCreate: RGMessagesEntityCreate
    
    var path: String { "/clientarea/message" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: RGMessagesEntityCreate? { messagesEntityCreate }
}
