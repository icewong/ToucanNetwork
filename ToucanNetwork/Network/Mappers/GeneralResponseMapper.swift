//
//  ResponseMapper.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class GeneralResponseMapper: ResponseMapper<ResponseItem>, ResponseMapperProtocol  {
    
    static func process(_ obj: AnyObject?) throws -> ResponseItem {
        return try process(obj, parse: { resultDic in
            
            
            if resultDic["statusCode"] != nil && resultDic["statusString"] != nil {
                let statuscode     = resultDic["statusCode"] as? String
                let statusstring   = resultDic["statusString"] as? String
                return ResponseItem(statuscode: statuscode!, responseMessage: statusstring!)
            }
            return nil
        })
    }
}
