//
//  SignOutRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SignOutRequest: BackendAPIRequest {
    

    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/logout.app"
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
        
        let nowDate = NSDate.init().iso8601String()
        dict.setValue(nowDate, forKey: "dateTime")
        
        let AppMode = "0402"
        dict.setValue(AppMode, forKey: "appModel")
        
        let signoutXml = XMLOperation.init().writeXML(dict)
        return signoutXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return true
    }
}
