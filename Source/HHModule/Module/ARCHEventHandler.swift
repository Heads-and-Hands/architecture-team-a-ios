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

open class ARCHEventHandler<State: ARCHState>: ACRHViewOutput, ARCHModuleInput, ARCHModuleOutput {
    public weak var router: ARCHRouter?
    public weak var viewInput: ARCHViewInput?
    public weak var childModuleOutput: ARCHModuleOutput?
    public var stateHandler: ARCHStateHandler<State>?

    public var childIdentifires: [String: UUID] = [:]

    private var ignoreStateChanges: Bool = false
    private var isShouldRenderMethodCalled: Bool = false

    public init() {}

    public var state: State = State() {
        willSet {
            stateHandler?.willUpdate(state: state, newState: newValue)
        }
        didSet {
            if let state = stateHandler?.currentState {
                self.state = state
            }

            if !isShouldRenderMethodCalled {
                childModuleOutput?.didChange(childState: state)
            }

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

    open func updateState(with childState: ARCHState) {
        guard let index = state.childStates.index(where: { $0.id == childState.id }) else {
            return
        }

        updateState { self.state.childStates[index] = childState }
    }

    // MARK: - ACRHViewOutput

    open func viewIsReady() {
        viewSetNeedsRedraw()
    }

    open func viewSetNeedsRedraw() {
        if !ignoreStateChanges {
            viewInput?.update(state: state)
        }
    }

    open func shouldRender(_ state: Any) -> Bool {
        guard let state = state as? State, self.state.id == state.id else {
            return false
        }

        ignoreStateChanges = true
        isShouldRenderMethodCalled = true
        self.state = state
        isShouldRenderMethodCalled = false
        ignoreStateChanges = false

        return true
    }

    open func reuseIdentifire(for childId: UUID) -> String? {
        guard let row = childIdentifires.first(where: { $0.value == childId }) else {
            return nil
        }
        return row.key
    }

    // MARK: - ARCHModuleInput

    open func getState() -> ARCHState {
        return state
    }

    open func setOutput(_ output: ARCHModuleOutput) {
        self.childModuleOutput = output
    }

    open func registerChildModule(_ module: ARCHModuleInput, for reuseIdentifire: String) {
        let childState = module.getState()
        childIdentifires[reuseIdentifire] = childState.id
        state.childStates.append(childState)
        module.setOutput(self)
    }

    // MARK: - ARCHModuleOutput

    open func didChange(childState: ARCHState) {
        updateState(with: childState)
    }

    // MARK: - Private

    public func childState(for reuseIdentifire: String) -> ARCHState? {
        guard let uuid = childIdentifires[reuseIdentifire] else {
            return nil
        }

        return state.childStates.first(where: { $0.id == uuid })
    }
}
