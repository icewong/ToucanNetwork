//
//  ForgetpsdOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ForgetPsdOperation: ServiceOperation {
    private let request: ForgetPasswordRequest
    
    public var success: ((ResponseItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public init(email: String) {
        request = ForgetPasswordRequest(email: email)
        super.init()
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try GeneralResponseMapper.process(response)
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
