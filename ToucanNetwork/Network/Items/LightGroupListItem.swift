//
//  LightGroupListItem.swift
//  ToucanNetwork
//
//  Created by bing wang on 14/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class LightGroupListItem: ParsedItem {
    
    public let listGroupArray: NSMutableArray!
    public init(listGroupArray: NSMutableArray) {
        self.listGroupArray = listGroupArray
    }
}
