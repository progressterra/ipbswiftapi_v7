//
//  CatalogCategoryRequest.swift
//  
//
//  Created by Artemy Volkov on 10.07.2023.
//

struct CatalogCategoryRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<RFCatalogCategoryViewModel>
    
    let accessToken: String
    let idCategory: String
    
    var path: String { "/browsing/category/" + idCategory }
    var method: HTTPMethod { .get }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
