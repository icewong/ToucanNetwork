//
//  ServiceOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 25/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ServiceOperation: NetworkOperation {

    let service: BackendService
    
    public override init() {
        self.service = BackendService(BackendConfiguration.shared)
        super.init()
    }
    
    public override func cancel() {
        service.cancel()
        super.cancel()
    }
    
}
