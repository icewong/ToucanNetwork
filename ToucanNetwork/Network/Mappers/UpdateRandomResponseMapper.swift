//
//  UpdateRandomResponseMapper.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class UpdateRandomResponseMapper: ResponseMapper<RandomItem>, ResponseMapperProtocol  {
    
    static func process(_ obj: AnyObject?) throws -> RandomItem {
    return try process(obj, parse: { resultDic in
    
    
        if resultDic["ResponseStatus"]!["statusCode"] != nil {
            if resultDic["ResponseStatus"]!["statusCode"] as! String == "0" {
                let random = resultDic["random"] as! String
                return RandomItem(random: random)
            }else {
                
            }
        }else {
            
        }
        
        return nil
    })
    }
}
