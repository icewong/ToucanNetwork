//
//  NetworkQueue.swift
//  ToucanNetwork
//
//  Created by bing wang on 25/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import Foundation

public class NetworkQueue {
    
    public static var shared: NetworkQueue!
    
    let queue = OperationQueue()
    
    public init() {}
    
    public func addOperation(_ op: Operation) {
        queue.addOperation(op)
    }
}
