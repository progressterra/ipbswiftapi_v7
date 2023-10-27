//
//  ResultDataModel.swift
//  
//
//  Created by Artemy Volkov on 06.07.2023.
//

import Foundation


public protocol ResultContaining {
    var result: ResultOperation { get }
}

public struct ResultData<T: Codable>: Codable, ResultContaining {
    public var result: ResultOperation
    public var data: T?
    public var totalNumberRecords: Int
}
