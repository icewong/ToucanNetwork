//
//  SignUpOperation.swift
//  ToucanNetwork
//
//  Created by bing wang on 27/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class SignUpOperation: ServiceOperation {
    private let request: SignUpRequest
    
    public var success: ((ResponseItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
    public init(accountname: String, password: String,firstname:String,lastname:String) {
        request = SignUpRequest(accountname: accountname, password: password, firstname: firstname, lastname: lastname)
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
