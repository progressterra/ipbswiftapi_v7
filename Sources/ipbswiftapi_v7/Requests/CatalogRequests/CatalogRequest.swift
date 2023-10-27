//
//  CatalogRequest.swift
//  
//
//  Created by Artemy Volkov on 10.07.2023.
//

struct CatalogRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<CatalogItem>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/browsing/catalog" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: Parameters? { filter }   
}
