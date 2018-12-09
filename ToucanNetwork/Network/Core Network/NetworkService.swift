//
//  NetworkService.swift
//  ToucanNetwork
//
//  Created by bing wang on 25/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

class NetworkService  {
    
    private var task : URLSessionDataTask?
    private var successCodes : CountableRange<Int> = 200..<299
    private var failureCodes : CountableRange<Int> = 400..<499
    
    enum Method:String {
        case get,post,put,delete
    }
    
    enum QueryType {
        case xml,json,path
    }
    //MARK: Private
    private func makeQuery(for url: URL, params: String, type: QueryType) -> URLRequest {
        switch type {
        case .json:
            var mutableRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                            timeoutInterval: 10.0)
//            if let params = params {
//                mutableRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
//            }
            
            return mutableRequest
        case .path:
            var query = ""
            
//            params?.forEach { key, value in
//                query = query + "\(key)=\(value)&"
//            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            
            return URLRequest(url: components.url!, timeoutInterval: 10.0)
        case .xml:

            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            return URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        }
        
    }
    func makeRequest(for url : URL,method : Method, query type : QueryType,
                     params  : String? = nil,
                     headers : [String : String]? = nil,
                     needDigest : Bool? = false,
                     success : ((Data?) -> Void)? = nil,
                     failure : ((_ data : Data?, _ error : NSError?,_ responseCode: Int) -> Void)? = nil) {
        
        
        var mutableRequest = makeQuery(for: url, params: params!, type: type)
        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue
        let xmlData = params!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        mutableRequest.httpBody   = xmlData
        
        if (needDigest!) {
            mutableRequest.addValue("Digest userId = \(DigestManager.shared().userId),response =\(DigestManager.shared().getDigest(method.rawValue, url: (url.path)))", forHTTPHeaderField: "Authorization")
        }
        //
        //let session = URLSession.shared
        let config  = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        NetworkLogger.log(request: mutableRequest)
        task = session.dataTask(with: mutableRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }
            if error == nil {
            
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {

                    } else {
                        //通知UI接口执行失败
//                        let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
//                        failure?(data, error, response.statusCode)
//                        return
                    }
                }
            
            }
            if let error = error {
                // Request failed, might be internet connection issue
                failure?(data, error as NSError, httpResponse.statusCode)
                return
            }
            if self.successCodes.contains(httpResponse.statusCode) {
                print("Request finished with success.")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                print("Request finished with failure.")
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                print("Request finished with serious failure.")
                // Server returned response with status code different than
                // expected `successCodes`.
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, error, httpResponse.statusCode)
            }
        })
        
        task?.resume()
    }
    func cancel() {
        task?.cancel()
    }
}
