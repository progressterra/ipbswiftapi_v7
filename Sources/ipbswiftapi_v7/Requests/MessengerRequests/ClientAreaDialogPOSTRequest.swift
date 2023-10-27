//
//  ClientAreaDialogPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 04.08.2023.
//

import Foundation

struct ClientAreaDialogPOSTRequest: Request {
    typealias Parameters = IncomeDataForCreateDialog
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGDialogsViewModel>
    
    let accessToken: String
    let incomeData: IncomeDataForCreateDialog
    
    var path: String { "/clientarea/dialog" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: IncomeDataForCreateDialog? { incomeData }
}
