//
//  ResponseItem.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ResponseItem: ParsedItem {
    public let statuscode: String!
    public let responseMessage: String
    
    public init(statuscode: String, responseMessage: String) {
        self.statuscode      = statuscode
        self.responseMessage = responseMessage
    }
}
