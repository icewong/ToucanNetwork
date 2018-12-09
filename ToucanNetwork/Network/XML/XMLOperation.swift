//
//  XMLOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit
import XMLDictionary
class XMLOperation: NSObject {
    
    func readXML(_ xmlData:XMLParser)->NSDictionary{
        do{
            let dict = NSDictionary.init(xmlParser: xmlData)
            return dict!
        }catch{
            
        }
        
    }
    
    func readXMLByData(_ xmlData:Data)->NSDictionary{
        do{
            let dict = NSDictionary.init(xmlData: xmlData)
            return dict!
        }catch{

        }
    }
    
    func writeXML(_ dict:NSDictionary)->String{
        let XMLString:String = XMLWriter.xmlString(from: dict as! [AnyHashable : Any], withHeader: true)
        return XMLString
    }
    
    func writeXMLWithHeader(_ dict:NSDictionary, header:String)->String{
        //let XMLString:String = XMLWriter.xmlString(from: dict as! [AnyHashable : Any], withHeader: true,name:header)
        let XMLString:String = XMLWriter.xmlString(fromDictionaryHeader: dict as! [AnyHashable : Any], withHeader: true, name: header)
        return XMLString
    }
}
