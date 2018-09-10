//
//  Protocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol MockStateProtocol: Equatable & ARCHState {

    associatedtype T: Equatable

    var value: T { get set }

    init()

    mutating func chageRandomly(constraint: T?)
}

protocol TestState: ARCHState {

    associatedtype MockState: MockStateProtocol

    var mockState: MockState { get set }
}

protocol ViewOutput: ACRHViewOutput {
}
