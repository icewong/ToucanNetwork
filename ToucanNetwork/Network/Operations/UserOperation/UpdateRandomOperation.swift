//
//  UpdateRandomOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class UpdateRandomOperation: ServiceOperation {
    private let request: UpdateRandomRequest
    
    public var success: ((RandomItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public override init() {
        request = UpdateRandomRequest()
        super.init()
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try UpdateRandomResponseMapper.process(response)
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
