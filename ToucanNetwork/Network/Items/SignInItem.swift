//
//  SignInItem.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

class SignInItem: ParsedItem {

    public var random: String = ""
    public var userId: String = ""
    
    public init(random: String! = nil, userId: String) {
        self.random = random
        self.userId = userId
    }
}
