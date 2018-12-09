//
//  ProfileInfoOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 12/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ProfileInfoOperation: ServiceOperation {
    private let request: ProfileInfoRequest
    
    public var success: ((ProfileInfoItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public override init() {
        request = ProfileInfoRequest()
        super.init()
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try ProfileInfoResponseMapper.process(response)
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
