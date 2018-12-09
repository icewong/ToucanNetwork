//
//  DigestManager.swift
//  ToucanNetwork
//
//  Created by bing wang on 12/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class DigestManager: NSObject {
    
    var userId:String = ""
    var random:String = ""
      static let _shareManager = DigestManager()
      class func shared()->DigestManager {
          return _shareManager
     }
    func config(_ userId:String, _ random:String) {
        self.userId = userId
        self.random = random
    }
    func getDigest(_ method:String, url:String) -> String{

        let key1 = "\(self.userId):\(self.random)".md5()
        let key2 = "\(method):\(url)".md5()
        let key3 = "\(key1):\(self.random):\(key2)".md5()
        return key3
    }
}
