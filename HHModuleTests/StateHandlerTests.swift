//
//  StateHandlerTests.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import XCTest
@testable import HHModule

class StateHandlerTests<MState: TestState>: XCTestCase {

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

    open func testSetState() {

        let module = self.module

        let defaultState = mockState
        var notAllowedState = mockState
        notAllowedState.chageRandomly(constraint: defaultState.value)

        let stateHandler = StateHandler<MState>(block: { old, new -> MState in
            var result = new
            if new.mockState == notAllowedState {
                result.mockState = defaultState
            }
            return result
        })

        module.eventHandler.stateHandler = stateHandler
        module.eventHandler.state.mockState = defaultState

        verification(module: module, error: "Test state handler fail set state")
    }

    open func testSetNotAllowedState() {

        let module = self.module

        let defaultState = mockState
        var notAllowedState = mockState
        notAllowedState.chageRandomly(constraint: defaultState.value)

        let stateHandler = StateHandler<MState>(block: { old, new -> MState in
            var result = new
            if new.mockState == notAllowedState {
                result.mockState = defaultState
            }
            return result
        })

        module.eventHandler.stateHandler = stateHandler
        module.eventHandler.state.mockState = notAllowedState

        verification(module: module, error: "Test state handler fail set state", comparator: !=)
    }
}
