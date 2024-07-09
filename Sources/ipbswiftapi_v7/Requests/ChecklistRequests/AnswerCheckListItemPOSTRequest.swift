//
//  AnswerCheckListItemPOSTRequest.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

struct AnswerCheckListItemPOSTRequest: Request {
    typealias Parameters = DRAnswerCheckListItemEntity
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFTestParameters>
    
    let accessToken: String
    let answerCheckListItemEntity: DRAnswerCheckListItemEntity
    
    var path: String { "/answerchecklistitem" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: DRAnswerCheckListItemEntity? { answerCheckListItemEntity }
}
