//
//  NetworkConfiguration.swift
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case development
    case production
}
class NetworkConfiguration {
    
    class func setup(_ environment:NetworkEnvironment) {
        //Configuration
       let url = (environment == .production) ? URL(string: "https://blc.smartlight.qmulux.com:443")!:URL(string: "https://blc.smartlight.qmulux-demo.com:443")!
       let conf = BackendConfiguration(baseURL: url)
       BackendConfiguration.shared = conf
        
        // Network Queue
        NetworkQueue.shared = NetworkQueue()
    }
}


