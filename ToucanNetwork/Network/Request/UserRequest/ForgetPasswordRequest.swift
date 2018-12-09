//
//  ForgetPasswordRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ForgetPasswordRequest: BackendAPIRequest {
    private let email: String
    
    init(email: String) {
        self.email = email
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/forgetPw.app"
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
        let forgetXml = XMLOperation.init().writeXMLWithHeader(dict, header: "appUserForgetPassword")
        return forgetXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    var needDigest: Bool {
        return false
    }
}
