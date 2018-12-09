//
//  BackendService.swift
//  ToucanNetwork
//
//  Created by bing wang on 25/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

public let DidPerformUnauthorizedOperation = "DidPerformUnauthorizedOperation"

class BackendService {
    
    private let conf: BackendConfiguration
    private let service = NetworkService()
    
    init(_ conf: BackendConfiguration) {
        self.conf = conf
    }
    
    func request(_ request: BackendAPIRequest,
                 success: ((AnyObject?) -> Void)? = nil,
                 failure: ((NSError) -> Void)? = nil) {
        
        let url = conf.baseURL.appendingPathComponent(request.endpoint)
        
        let headers = request.headers
        // Set authentication token if available.
        //        headers?["X-Api-Auth-Token"] = BackendAuth.shared.token
        
        service.makeRequest(for: url, method: request.method, query: request.query, params: request.parameters, headers: headers,needDigest : request.needDigest, success: { data in
            var reslutDic: NSDictionary? = nil
            if let data = data {
                reslutDic = try? XMLOperation.init().readXMLByData(data)
            }
            print("*******\(reslutDic)")
            if reslutDic!["statusCode"] != nil {
                let statusCodeStr  = reslutDic!["statusCode"] as! String
                if statusCodeStr == "0" {
                    success?(reslutDic)
                }else {
                    let info = [
                        NSLocalizedDescriptionKey: reslutDic!["statusString"] as? String ?? "",
                        NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                    ]
                    let errorCode = Int(statusCodeStr.substring(from: 2))
                    let error = NSError(domain: "BackendService", code: errorCode!, userInfo: info)
                    failure?(error)
                }
            }else {
                let responseStatus = reslutDic!["ResponseStatus"] as! NSDictionary
                let statusCodeStr  = responseStatus["statusCode"] as! String
                if statusCodeStr == "0" {
                    success?(reslutDic)
                }else {
                    let info = [
                        NSLocalizedDescriptionKey: responseStatus["statusString"] as? String ?? "",
                        NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                    ]
                    let errorCode = Int(statusCodeStr.substring(from: 2))
                    let error = NSError(domain: "BackendService", code: errorCode!, userInfo: info)
                    failure?(error)
                }
            }
        }, failure: { data, error, statusCode in
            
            print("***error******\(String(describing: error))")
            
            if statusCode == 401 {
                // Operation not authorized
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidPerformUnauthorizedOperation), object: nil)
                failure?(error ?? NSError(domain: "DidPerformUnauthorizedOperation", code: 401, userInfo: nil))
                return
            }
            if let data = data {
                let reslutDic = try? XMLOperation.init().readXMLByData(data)
                let info = [
                    NSLocalizedDescriptionKey: reslutDic?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "BackendService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "BackendService", code: 0, userInfo: nil))
            }
        })
    }
    
    func cancel() {
        service.cancel()
    }
}
