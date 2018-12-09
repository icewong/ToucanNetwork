//
//  LightListOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 14/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class LightListOperation: ServiceOperation {
    private let request: LightListRequest
    public var success: ((LightGroupListItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public override init() {
        request = LightListRequest()
        super.init()
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try GroupListResponseMapper.process(response)
            self.success?(item)
            self.finish()
        } catch {
            handleFailure(NSError.cannotParseResponse())
        }
    }
    private func handleFailure(_ error: NSError) {
        self.failure?(error)
        self.finish()
    }
}
