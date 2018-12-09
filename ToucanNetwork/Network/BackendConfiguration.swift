//
//  BackendConfiguration.swift
//  ToucanNetwork
//
//  Created by bing wang on 21/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation



public final class BackendConfiguration {
    
    let baseURL:URL
    //let networkEnvironment:NetworkEnvironment
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
     
    public static var shared: BackendConfiguration!
}
