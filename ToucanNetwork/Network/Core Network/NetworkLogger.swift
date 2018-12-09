//
//  NetworkLogger.swift
//  ToucanNetwork
//
//  Created by bing wang on 28/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation
class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUT REQUEST - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: URLResponse) {
        
        print("\n - - - - - - - - - - OUT RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
//        let textEncodingName = response.textEncodingName
//        let suggestedFilename = response.suggestedFilename
//        let statusCode = response.s?.absoluteString ?? ""
//        let urlComponents = NSURLComponents(string: urlAsString)
//
//        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
//        let path = "\(urlComponents?.path ?? "")"
//        let query = "\(urlComponents?.query ?? "")"
//        let host = "\(urlComponents?.host ?? "")"
//
//        var logOutput = """
//        \(urlAsString) \n\n
//        \(method) \(path)?\(query) HTTP/1.1 \n
//        HOST: \(host)\n
//        """
//        for (key,value) in request.allHTTPHeaderFields ?? [:] {
//            logOutput += "\(key): \(value) \n"
//        }
//        if let body = request.httpBody {
//            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
//        }
//
//        print(logOutput)
        
    }
}
