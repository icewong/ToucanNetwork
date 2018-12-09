//
//  ProfileInfoRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 28/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ProfileInfoRequest: BackendAPIRequest {
    
    private let accountname: String = ""
    private let firstname: String = ""
    private let lastname: String = ""
    init() {

    }
    
    var endpoint: String {
        return String(format: "/sklcloud/app/Security/AAA/users/%@/modifyInfo.app", DigestManager.shared().userId)
    }
    
    var method: NetworkService.Method {
        return .get
    }
    
    var query: NetworkService.QueryType {
        return .xml
    }
    
    var parameters: String {
        
        let dict = NSMutableDictionary.init()
        let nowDate = NSDate.init().iso8601String()
        dict.setValue(nowDate, forKey: "dateTime")
        let AppMode = "0402"
        dict.setValue(AppMode, forKey: "appModel")
        
        let performInfoXml = XMLOperation.init().writeXML(dict)
        return performInfoXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    
    var needDigest: Bool {
        return true
    }
}
