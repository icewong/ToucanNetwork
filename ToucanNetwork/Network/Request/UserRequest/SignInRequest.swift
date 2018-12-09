//
//  SignInRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SignInRequest: BackendAPIRequest {

    private let email: String
    private let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/login.app"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var query: NetworkService.QueryType {
        return .xml
    }
    
    var parameters: String {
        
        let dict = NSMutableDictionary.init()
        dict.setValue(email, forKey: "email")
        
        let encodePw = AESOperation.init().encode(password)
        dict.setValue(encodePw, forKey: "encodePw")
        
        dict.setValue("0000000000000000", forKey: "random")
        
        let nowDate = NSDate.init().iso8601String()
        dict.setValue(nowDate, forKey: "dateTime")
        
        let AppMode = "0402"
        dict.setValue(AppMode, forKey: "appModel")
        
        let logInXml = XMLOperation.init().writeXMLWithHeader(dict, header: "appUserLogin")
        return logInXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return false
    }
}
