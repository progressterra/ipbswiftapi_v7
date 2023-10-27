//
//  ProductByIDRequest.swift
//  
//
//  Created by Artemy Volkov on 11.07.2023.
//

struct ProductByIDRequest: Request {
    typealias Parameters = [String: String]?
    typealias QueryParameters = [String: String]?
    typealias ReturnType = ResultData<ProductViewDataModel>
    
    let accessToken: String
    let idRFNomenclature: String
    
    var path: String { "/product/" + idRFNomenclature }
    var method: HTTPMethod { .get }
    var token: String? { accessToken }
    var contentType: String? { nil }
}
