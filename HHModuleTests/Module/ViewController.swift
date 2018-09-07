//
//  ViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ViewController<Out: ViewOutput, S: TestState>: ARCHViewController<S, Out> {

    let mockView = MockView<S.MockState>()
}
