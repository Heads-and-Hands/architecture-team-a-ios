//
//  StateTests.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import XCTest
@testable import HHModule

class StateTests<MState: TestState>: XCTestCase {

    private typealias MockState = MState.MockState
    private typealias Module = (view: ViewController<EventHandler<MState>, MState>, eventHandler: EventHandler<MState>)

    private let configurator = Configurator<MState>()

    private var module: Module {
        let router = configurator.router
        guard let controller = router as? ViewController<EventHandler<MState>, MState> else {
            fatalError("Initialization error")
        }

        guard let eventHandler = controller.output else {
            fatalError("Initialization error")
        }

        return (controller, eventHandler)
    }

    private var mockState: MockState {
        return MockState.init()
    }

    private func verification(module: Module, error: String, comparator: ((MockState, MockState) -> Bool) = { $0 == $1 }) {
        let mockViewState = module.view.mockView.state ?? MockState.init()

        let mockState = module.eventHandler.state.mockState

        let result = comparator(mockViewState, mockState)
        XCTAssert(result, error)
    }

    // MARK: - Tests

    open func testStateInitialization() {
        let module = self.module
        var moduleState = MState()
        moduleState.mockState = mockState

        module.eventHandler.state = moduleState

        verification(module: module, error: "Initialization fail")
    }

    open func testSetSubstate() {
        let module = self.module
        let mockState = self.mockState

        module.eventHandler.state.mockState = mockState

        verification(module: module, error: "Set substate fail")
    }

    open func testChangeSubstate() {
        let module = self.module
        let mockState = self.mockState

        module.eventHandler.state.mockState = mockState

        module.eventHandler.state.mockState.chageRandomly(constraint: nil)

        verification(module: module, error: "Change substate fail")
    }

    open func testChangeSubstateIndirectly() {
        let module = self.module
        var mockState = self.mockState

        module.eventHandler.state.mockState = mockState
        mockState.chageRandomly(constraint: nil)

        verification(module: module, error: "Change substate indirectly fail")
    }

    open func testSetSubstateWithBlock() {
        let module = self.module
        let mockState = self.mockState

        module.eventHandler.beginStateChanges()
        module.eventHandler.state.mockState = mockState

        verification(module: module, error: "Set substate with block fail", comparator: !=)

        module.eventHandler.commitStateChanges()

        verification(module: module, error: "Set substate with block fail")
    }

    open func testChangeSubstateWithBlock() {
        let module = self.module
        let mockState = self.mockState

        module.eventHandler.state.mockState = mockState

        module.eventHandler.beginStateChanges()

        module.eventHandler.state.mockState.chageRandomly(constraint: nil)

        verification(module: module, error: "Change substate with block change state fail", comparator: !=)

        module.eventHandler.commitStateChanges()

        verification(module: module, error: "Change substate with block update state fail")
    }

    open func testChangeSubstateWithBlockIndirect() {
        let module = self.module
        var mockState = self.mockState

        module.eventHandler.state.mockState = mockState

        module.eventHandler.beginStateChanges()
        mockState.chageRandomly(constraint: nil)

        verification(module: module, error: "Change substate indirect with block change state fail", comparator: !=)

        module.eventHandler.commitStateChanges()

        verification(module: module, error: "Change substate indirect with block update state fail")
    }
}

