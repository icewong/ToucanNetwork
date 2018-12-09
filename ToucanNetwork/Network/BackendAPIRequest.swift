//
//  BackendAPIRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 25/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation
protocol BackendAPIRequest {
    var endpoint : String { get }
    var method : NetworkService.Method { get }
    var query  : NetworkService.QueryType { get }
    var parameters : String { get }
    var headers : [String : String]? { get }
    var needDigest :Bool { get }
}

extension BackendAPIRequest {
   
    
    func defaultXMLHeaders() -> [String: String] {
        return ["Content-Type": "application/xml"]
    }
}
