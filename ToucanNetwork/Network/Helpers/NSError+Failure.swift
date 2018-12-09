//
//  NSError+Failure.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

extension NSError {
    class func cannotParseResponse() -> NSError {
        let info = [NSLocalizedDescriptionKey: "Can't parse response. Please report a bug."]
        return NSError(domain: String(describing: self), code: 0, userInfo: info)
    }
}
