//
//  State.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct StructState<T: MockStateProtocol>: TestState {
    typealias MockState = T
    var mockState: MockState = MockState.init()
}

class ClassState<T: MockStateProtocol>: TestState {
    typealias MockState = T
    var mockState: MockState = MockState.init()

    required init() {}
}

