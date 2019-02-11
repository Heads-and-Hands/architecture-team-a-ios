//
//  ARCHEventHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

open class ARCHStateHandler<T> {
    public let block: (T, T) -> T?
    public var currentState: T?

    public init(block: @escaping (T, T) -> T?) {
        self.block = block
    }

    open func willUpdate(state: T, newState: T) {
        currentState = block(state, newState)
    }
}

open class ARCHEventHandler<State: ARCHState>: ACRHViewOutput {
    public weak var router: ARCHRouter?
    public weak var viewInput: ARCHViewInput?
    public var stateHandler: ARCHStateHandler<State>?

    private var ignoreStateChanges: Bool = false
    private var renderDisable: Bool = false
    private var syncRender: Bool = false

    private var redrawQueue = DispatchQueue(label: "RedrawQueue", qos: .userInteractive)

    private let debugLog: ((String) -> Void)? = {
        if let debugMode = ProcessInfo.processInfo.environment["ARCHEventHandlerDebugMode"], Int(debugMode) == 1 {
            return { print("[\(Thread.isMainThread ? "Main" : "RedrawQueue")][ARCHEventHandler] " + $0) }
        } else {
            return nil
        }
    }()

    public init() {}

    public var state: State = State() {
        willSet {
            debugLog?("will set new state")
            stateHandler?.willUpdate(state: state, newState: newValue)
        }
        didSet {
            if let state = stateHandler?.currentState {
                debugLog?("didSet >> stateHandler update current state")
                self.state = state
            }

            viewSetNeedsRedraw()
        }
    }

    open func beginStateChanges() {
        debugLog?("start state changes transaction")
        ignoreStateChanges = true
    }

    open func commitStateChanges() {
        debugLog?("commit changes")
        ignoreStateChanges = false
        viewSetNeedsRedraw()
    }

    open func syncUpdateState(_ block: () -> Void) {
        debugLog?("sync begin")
        syncRender = true
        updateState(block)
        syncRender = false
        debugLog?("sync commit")
    }

    open func updateState(_ block: () -> Void) {
        beginStateChanges()
        block()
        commitStateChanges()
    }

    open func updateStateWithoutRender(_ block: () -> Void) {
        debugLog?("render disable")
        renderDisable = true
        updateState(block)
        renderDisable = false
        debugLog?("render enable")
    }

    // MARK: - ACRHViewOutput

    open func viewIsReady() {
        viewSetNeedsRedraw()
    }

    open func viewSetNeedsRedraw() {
        guard !ignoreStateChanges, !renderDisable else {
            return
        }

        debugLog?("viewSetNeedsRedraw")

        let state = self.state

        if syncRender {
            debugLog?("[SYNC] viewInput >> update(state:)")
            viewInput?.update(state: state)
        } else {
            redrawQueue.async { [weak self] in
                self?.viewRedraw(state: state)
            }
        }
    }

    private func viewRedraw(state: State) {
        debugLog?("viewRedraw")
        DispatchQueue.main.sync { [weak self] in
            self?.debugLog?("viewInput >> update(state:)")
            self?.viewInput?.update(state: state)
        }
    }
}
