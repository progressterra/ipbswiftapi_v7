//
//  DRAnswerCheckListItemEntity.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct DRAnswerCheckListItemEntity: Codable {
    public let iddrCheckListItem: String
    public let yesNo: Bool?
    public let comments: String?
    public let rangeValue: Int?
    public let specificMeaning: Double?
    public let specificFreeMeaning: String?
    
    public init(
        iddrCheckListItem: String,
        yesNo: Bool?,
        comments: String?,
        rangeValue: Int? = nil,
        specificMeaning: Double? = nil,
        specificFreeMeaning: String? = nil
    ) {
        self.iddrCheckListItem = iddrCheckListItem
        self.yesNo = yesNo
        self.comments = comments
        self.rangeValue = rangeValue
        self.specificMeaning = specificMeaning
        self.specificFreeMeaning = specificFreeMeaning
    }
}
