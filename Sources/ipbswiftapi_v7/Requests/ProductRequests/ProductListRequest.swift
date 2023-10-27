//
//  ProductListRequest.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

struct ProductListRequest: Request {
    typealias Parameters = FilterAndSort
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultDataList<ProductViewDataModel>
    
    let accessToken: String
    let filter: FilterAndSort
    
    var path: String { "/product/list" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: FilterAndSort? { filter }
}
