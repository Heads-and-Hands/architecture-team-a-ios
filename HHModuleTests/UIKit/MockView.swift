//
//  MockView.swift
//  HHModuleTests
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class MockView<T: MockStateProtocol>: ARCHViewRenderable {
    typealias State = T

    var state: T?

    func render(state: T) {
        self.state = state
    }
}
