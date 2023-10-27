//
//  ClientAreaDialogSearchPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 21.08.2023.
//

import Foundation

struct ClientAreaDialogSearchPOSTRequest: Request {
    typealias Parameters = IncomeDataSearchDialog
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RGDialogsViewModel>
    
    let accessToken: String
    let searchDialogData: IncomeDataSearchDialog
    
    var path: String { "/clientarea/dialog/search" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: IncomeDataSearchDialog? { searchDialogData }
}
