//
//  State.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct State<T: Equatable & ARCHState>: TestState {
    typealias MockState = T
    var mockState: MockState = MockState.init()
}
