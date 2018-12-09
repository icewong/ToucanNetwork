//
//  LightListRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 14/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class LightListRequest: BackendAPIRequest {

    init() {

    }
    
    var endpoint: String {
        return String(format: "/sklcloud/app/device/%@/querySirius.app", DigestManager.shared().userId)
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
        let lightListXml = XMLOperation.init().writeXML(dict)
        return lightListXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return true
    }
}
