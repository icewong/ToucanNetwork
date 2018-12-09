//
//  SignInResponseMapper.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SignInResponseMapper: ResponseMapper<SignInItem>, ResponseMapperProtocol  {

    static func process(_ obj: AnyObject?) throws -> SignInItem {
        return try process(obj, parse: { json in
            let userId = json["userId"] as? String
            let random   = json["random"] as? String
            if let random = random, let userId = userId {
                DigestManager.shared().config(userId, random)
                return SignInItem(random: random, userId: userId)
            }
            return nil
        })
    }
}
