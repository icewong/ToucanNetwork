//
//  ProfileInfoItem.swift
//  ToucanNetwork
//
//  Created by bing wang on 28/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ProfileInfoItem: ParsedItem {

    public var firstname: String
    public var lastname: String
    public var accountname: String
    
    public init(accountname: String! = nil,firstname: String,lastname: String) {
        self.accountname = accountname
        self.firstname   = firstname
        self.lastname    = lastname
    }
}
