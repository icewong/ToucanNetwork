//
//  ProfileInfoResponseMapper.swift
//  ToucanNetwork
//
//  Created by bing wang on 12/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ProfileInfoResponseMapper: ResponseMapper<ProfileInfoItem>, ResponseMapperProtocol  {
    static func process(_ obj: AnyObject?) throws -> ProfileInfoItem {
        return try process(obj, parse: { resultDic in
            
            if resultDic["ResponseStatus"]!["statusCode"] != nil {
                if resultDic["ResponseStatus"]!["statusCode"] as! String == "0" {
                    let encodeData = resultDic["encodeData"] as! String
                    let decodeData = AESOperation().decode(encodeData, datetime: resultDic["dateTime"] as! String, DigestManager.shared().random)
                    print("*****decodeData****\(decodeData)")
                    let per = XMLParser.init(data: decodeData.data(using: .utf8)!)
                    print("*****per****\(per)")
                    let decodeDict =  XMLOperation.init().readXML(per)
                    
                    var accountname = ""
                    var firstname = ""
                    var lastname = ""

                    if let value = decodeDict["email"] as? String{
                        accountname = value
                    }
                    if let value = decodeDict["firstName"] as? String{
                        firstname = value
                    }
                    if let value = decodeDict["lastName"] as? String{
                        lastname = value
                    }
                    return ProfileInfoItem(accountname: accountname, firstname: firstname, lastname: lastname)
                }else {
                   
                }
            }else {
                
            }
            
            return nil
        })
    }
}
