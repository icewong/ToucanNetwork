//
//  AESOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit
import CryptoSwift
import ISO8601

class AESOperation: NSObject {

    func encode(_ password:String) -> String {
        let cal = NSCalendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday
        ]
        let components = cal.dateComponents(requestedComponents, from: Date())
        let asekey = String.init(format: "%.2ld%.2ld%.2ld%.2ldskylight", components.day!,components.hour!,components.minute!,components.second!)
        do{
            let aseTools = try AES.init(key: asekey, iv: "0000000000000000", padding: .noPadding)
            let keyString = try aseTools.encrypt(Array(password.md5().utf8))
            return keyString.toBase64()!
        }catch{
            
        }
        return "123"
    }
    
    func encodeQkey(_ password:String) -> String {
        let cal = NSCalendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday
        ]
        let components = cal.dateComponents(requestedComponents, from: Date())
        let startRange = password.md5().index(password.md5().startIndex, offsetBy: 8)
        let endRange = password.md5().index(password.md5().startIndex, offsetBy: 8+16)
        let passwordMD5 = password.md5().substring(with: startRange..<endRange).uppercased()
        let asekey = String.init(format: "%@%.2ld%.2ld",passwordMD5.substring(to: 12),components.minute!,components.second!)
        
        do{
            
            let aseTools = try AES.init(key: asekey, iv: "0000000000000000", padding: .noPadding)
            let keyString = try aseTools.encrypt(Array(passwordMD5.utf8))
            return keyString.toBase64()!
            
            
        }catch{
            
        }
        return "123"
    }
    func encodeWithRandom(_ password:String,_ random:String) -> String {
        let cal = NSCalendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday
        ]
        let components = cal.dateComponents(requestedComponents, from: Date())
        let userRandom = random
        let subRandom = String(userRandom[..<12])
        let asekey = String.init(format: subRandom+"%.2ld%.2ld",components.minute!,components.second!)
        
        let keyString = AESCrypt.aes128Encrypt(password, withKey: asekey, iv: "0000000000000000")
        return keyString!
    }
    func decode(_ password:String, datetime:String,_ random:String) -> String {
        let cal = NSCalendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday
        ]
        let dataTime1 = NSDate.init(iso8601String: datetime)
        let components = cal.dateComponents(requestedComponents, from: dataTime1! as Date)
        if random == nil {
            return ""
        }
        let userRandom = random
        let subRandom = String(userRandom[..<12])
        let asekey = String.init(format: subRandom+"%.2ld%.2ld",components.minute!,components.second!)
        
        do{
            let aseTools = try AES.init(key: asekey, iv: "0000000000000000", padding: .noPadding)
            let String1 = AESCrypt.aes128Decrypt(password, withKey: asekey, iv: "0000000000000000")
            
            if(String1 == nil) {
                return "";
            }else {
                return String1!
            }
        }catch{
            
            print("catchcatchcatchcatch")
        }
        return "123"
    }
    
}
