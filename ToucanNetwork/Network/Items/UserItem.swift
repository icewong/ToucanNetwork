//
//  UserItem.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class UserItem: ParsedItem {
    
    /// The property is nil when passed for sign in or sign up operations.
    public let uniqueId: String!
    
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phoneNumber: String?
    
    public init(uniqueId: String! = nil, firstName: String, lastName: String,
                email: String, phoneNumber: String?) {
        self.uniqueId = uniqueId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
