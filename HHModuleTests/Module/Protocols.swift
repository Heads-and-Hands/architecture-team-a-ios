//
//  Protocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol TestState: ARCHState {
    associatedtype MockState: Equatable & ARCHState

    var mockState: MockState { get set }
}

protocol ViewOutput: ACRHViewOutput {
}
