//
//  UpdateRandomRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class UpdateRandomRequest: BackendAPIRequest {

    init() {
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/updateUserRandom.app"
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
        
        let updateInfoXml = XMLOperation.init().writeXMLWithHeader(dict, header: "updateUserRandom")
        return updateInfoXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    
    var needDigest: Bool {
        return true
    }
}
