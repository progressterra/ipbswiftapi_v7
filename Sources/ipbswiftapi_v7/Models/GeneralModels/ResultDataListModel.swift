//
//  ResultDataListModel.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

import Foundation

public struct ResultDataList<T: Codable>: Codable, ResultContaining {
    public let result: ResultOperation
    public let dataList: [T]?
    public let totalNumberRecords: Int
}
