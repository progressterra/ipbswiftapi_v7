//
//  DRCheckListItemForDHPerformedViewModel.swift
//
//  Created by Artemy Volkov on 18.12.2023.
//

import Foundation

public struct DRCheckListItemForDHPerformedViewModel: Codable, Equatable, Identifiable {
    public static func == (lhs: DRCheckListItemForDHPerformedViewModel, rhs: DRCheckListItemForDHPerformedViewModel) -> Bool {
        lhs.idUnique == rhs.idUnique
    }
    
    public var id: String { idUnique }
    
    public let idRegistrar: String
    public let iddrCheckListItemEntityTemplate: String?
    public let idrfTestParameters: String?
    public let description: String?
    public let shortDescription: String?
    public let needPhoto: Bool
    public let needVideo: Bool
    public let needComments: Bool
    public let needDecimalSpecificMeaning: Bool
    public let needSpecificFreeMeaning: Bool
    public let idUnique: String
    public let idEnterprise: String
    public let dateAdded: Date
    public let dateUpdated: Date
    public let dateSoftRemoved: Date?
    public let parameter: RFTestParameters
    public let answerCheckList: DRAnswerCheckListItemViewModel?
}
