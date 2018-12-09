//
//  SubmitTokenRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SubmitTokenRequest: BackendAPIRequest {
    private let pushToken: String
    
    init(token: String) {
        self.pushToken = token
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/token.app"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var query: NetworkService.QueryType {
        return .xml
    }
    
    var parameters: String {
        
        let dict = NSMutableDictionary.init()
        dict.setValue(DigestManager.shared().userId, forKey: "userId")
        dict.setValue(pushToken, forKey: "pushToken")
        dict.setValue("ios", forKey: "systemType")
        
        let pushtokenXml = XMLOperation.init().writeXMLWithHeader(dict, header: "token")
        return pushtokenXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return false
    }
}
