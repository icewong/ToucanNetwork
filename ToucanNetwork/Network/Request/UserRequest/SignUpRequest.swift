//
//  SignUpRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 27/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SignUpRequest: BackendAPIRequest {
    private let accountname: String
    private let password: String
    private let firstname: String
    private let lastname: String
    init(accountname: String, password: String,firstname:String,lastname:String) {
        self.accountname = accountname
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/validity.app"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var query: NetworkService.QueryType {
        return .xml
    }
    
    var parameters: String {
        
        let dict = NSMutableDictionary.init()
        dict.setValue(accountname, forKey: "email")
        
        let encodePw = AESOperation.init().encode(password)
        dict.setValue(encodePw, forKey: "encodePw")
        
        let nowDate = NSDate.init().iso8601String()
        dict.setValue(nowDate, forKey: "dateTime")
        
        if !firstname.isEmpty {
            dict.setValue(firstname, forKey: "firstName")
        }
        
        if !lastname.isEmpty {
            dict.setValue(lastname, forKey: "lastName")
        }
        
        let signUpXml = XMLOperation.init().writeXMLWithHeader(dict, header: "appNewUser")
        return signUpXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    
    var needDigest: Bool {
        return false
    }
}
