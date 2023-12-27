//
//  DRAnswerCheckListItemViewModel.swift
//
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct DRAnswerCheckListItemViewModel: Codable {
    public let iddrCheckListItem: String
    public let yesNo: Bool?
    public let comments: String?
    public let rangeValue: Int?
    public let specificMeaning: Double?
    public let specificFreeMeaning: String?
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let iddhCheckPerformed: String
    public let idClient: String
    public let idrfCheck: String
}
