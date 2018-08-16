//
//  ARCHEventHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

open class ARCHEventHandler<State: ARCHState>: ACRHViewOutput {
    public weak var router: ARCHRouter?
    public weak var viewInput: ARCHViewInputAbstact?
    private var ignoreStateChanges: Bool = false

    public init() {}

    public var state: State = State() {
        didSet {
            viewSetNeedsRedraw()
        }
    }

    open func beginStateChanges() {
        ignoreStateChanges = true
    }

    open func commitStateChanges() {
        ignoreStateChanges = false
        viewSetNeedsRedraw()
    }

    open func updateState(_ block: () -> Void) {
        beginStateChanges()
        block()
        commitStateChanges()
    }

    // MARK: - ACRHViewOutput

    open func viewIsReady() {
        viewSetNeedsRedraw()
    }

    open func viewSetNeedsRedraw() {
        if !ignoreStateChanges {
            viewInput?.abstractRender(state: state)
        }
    }
}
