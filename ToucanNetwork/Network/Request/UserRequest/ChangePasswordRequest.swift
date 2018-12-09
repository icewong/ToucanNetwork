//
//  ChangePasswordRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ChangePasswordRequest: BackendAPIRequest {
    private let newpassword: String
    private let oldpassword: String
    init(newpassword: String,oldpassword: String) {
        self.newpassword = newpassword
        self.oldpassword = oldpassword
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/changePw.app"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var query: NetworkService.QueryType {
        return .xml
    }
    
    var parameters: String {
        
        let nowDate = NSDate.init().iso8601String()
        let newpsdDict = NSMutableDictionary.init()
        newpsdDict.setValue(self.newpassword.md5(), forKey: "newPw")
        let newpsdXML = XMLWriter.xmlString(from: newpsdDict as! [AnyHashable : Any])
        
        let oldpsdDict = NSMutableDictionary.init()
        oldpsdDict.setValue(self.oldpassword.md5(), forKey: "oldPw")
        let oldpsdXML =  XMLWriter.xmlString(from: oldpsdDict as! [AnyHashable : Any])
        
        let xmlS = String.init(format: "%@%@", oldpsdXML,newpsdXML)
        let encodePw = AESOperation().encodeWithRandom(xmlS, DigestManager.shared().random)
        
        let dict = NSMutableDictionary.init()
        dict.setValue(nowDate, forKey: "dateTime")
        dict.setValue(encodePw, forKey: "encodeData")
        dict.setValue(DigestManager.shared().userId, forKey: "userId")
        
        let changePsdXml = XMLOperation.init().writeXMLWithHeader(dict, header: "changePw")
        return changePsdXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return true
    }
}
