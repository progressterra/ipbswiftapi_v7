//
//  DeviceTokenPOSTRequest.swift
//  
//
//  Created by Artemy Volkov on 18.09.2023.
//

struct DeviceTokenPOSTRequest: Request {
    typealias Parameters = RGDeviceTokenEntity
    typealias QueryParameters = [String: String]?
    typealias ReturnType =  ResultData<RGDeviceTokenViewModel>
    
    let accessToken: String
    let tokenEntity: RGDeviceTokenEntity
    
    var path: String { "/devicetoken" }
    var method: HTTPMethod { .post }
    var token: String? { accessToken }
    var body: RGDeviceTokenEntity? { tokenEntity }
}
