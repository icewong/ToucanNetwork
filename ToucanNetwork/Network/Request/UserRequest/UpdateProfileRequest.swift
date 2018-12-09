//
//  UpdateProfileRequest.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class UpdateProfileRequest: BackendAPIRequest {
    private let firstname: String
    private let lastname: String
    init(firstname:String,lastname:String) {
        self.firstname = firstname
        self.lastname  = lastname
    }
    
    var endpoint: String {
        return "/sklcloud/app/Security/AAA/users/modifyUserInfo.app"
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
        if !firstname.isEmpty {
            dict.setValue(firstname, forKey: "firstName")
        }
        if !lastname.isEmpty {
            dict.setValue(lastname, forKey: "lastName")
        }
        
        let updateInfoXml = XMLOperation.init().writeXMLWithHeader(dict, header: "userInfo")
        return updateInfoXml
    }
    
    var headers: [String : String]? {
        return defaultXMLHeaders()
    }
    
    var needDigest: Bool {
        return true
    }
}
