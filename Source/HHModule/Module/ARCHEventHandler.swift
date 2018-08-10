//
//  ARCHEventHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

open class ARCHEventHandler<State: ARCHState>: ACRHViewOutput {
    public weak var router: ARCHRouter?
    public weak var viewInput: ARCHViewInputAbstact?

    public init() {}

    public var state: State = State() {
        didSet {
            viewSetNeedsRedraw()
        }
    }

    // MARK: - ACRHViewOutput

    open func viewIsReady() {
        viewSetNeedsRedraw()
    }

    open func viewSetNeedsRedraw() {
        viewInput?.abstractRender(state: state)
    }
}
