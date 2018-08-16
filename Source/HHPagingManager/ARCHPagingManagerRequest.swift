//
//  ARCHPagingManagerRequest.swift
//  HHModuleDemo
//
//  Created by basalaev on 18.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public protocol ARCHPagingManagerCancellable: class {
    func cancel()
}

public class ARCHPagingManagerRequestWrapper: ARCHPagingManagerCancellable {

    public let block: () -> Void

    public init(block: @escaping () -> Void) {
        self.block = block
    }

    public func cancel() {
        block()
    }
}
