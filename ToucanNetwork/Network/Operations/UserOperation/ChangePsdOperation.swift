//
//  ChangePsdOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 13/10/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ChangePsdOperation: ServiceOperation {
    private let request: ChangePasswordRequest
    
    public var success: ((ResponseItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public init(newpasswod:String,oldpassword:String) {
        request = ChangePasswordRequest(newpassword: newpasswod, oldpassword: oldpassword)
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
