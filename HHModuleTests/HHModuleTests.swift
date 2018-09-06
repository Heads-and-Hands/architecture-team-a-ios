//
//  HHModuleTests.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import XCTest

@testable import HHModule

class HHModuleTests: XCTestCase {

    var structController: HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsStructState>, HHModuleTestsStructState>?
    var structEventHandler: HHModuleTestsEventHandler<HHModuleTestsStructState>?

    var classController: HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsClassState>, HHModuleTestsClassState>?
    var classEventHandler: HHModuleTestsEventHandler<HHModuleTestsClassState>?

    override func setUp() {
        super.setUp()

        structController = HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsStructState>, HHModuleTestsStructState>()

        structEventHandler = HHModuleTestsEventHandler<HHModuleTestsStructState>()
        structEventHandler?.viewInput = structController

        structController?.output = structEventHandler


        classController = HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsClassState>, HHModuleTestsClassState>()

        classEventHandler = HHModuleTestsEventHandler<HHModuleTestsClassState>()
        classEventHandler?.viewInput = classController

        classController?.output = classEventHandler
    }
    
    override func tearDown() {

        structController = nil

        structEventHandler = nil

        classController = nil

        classEventHandler = nil

        super.tearDown()
    }

    func testStructStateRenderInitialization() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        let state = HHModuleTestsStructState(structState: structState, classState: classState)

        eventHandler.state = state

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }
    
    func testStructStateRenderSetStruct() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        eventHandler.state.structState = structState

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderChangeRetainStruct() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        var structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        eventHandler.state.structState = structState

        structState.integerValue = randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue)

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderSetClass() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderChangeRetainClass() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderBlockStateChanges() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        eventHandler.beginStateChanges()

        eventHandler.state.structState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderRetainBlockStateChangClass() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        eventHandler.beginStateChanges()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateRenderRetainBlockStateChangStruct() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        var structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue))

        eventHandler.state.structState = structState

        eventHandler.beginStateChanges()

        structState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderInitialization() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        let state = HHModuleTestsClassState()

        state.structState = structState
        state.classState = classState

        eventHandler.state = state

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderSetStruct() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        eventHandler.state.structState = structState

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.viewSetNeedsRedraw()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderChangeRetainStruct() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        var structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        eventHandler.state.structState = structState

        eventHandler.viewSetNeedsRedraw()

        structState.integerValue = randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.viewSetNeedsRedraw()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderSetClass() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.viewSetNeedsRedraw()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderChangeRetainClass() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        eventHandler.viewSetNeedsRedraw()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.viewSetNeedsRedraw()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderBlockStateChanges() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        eventHandler.beginStateChanges()

        eventHandler.state.structState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderRetainBlockStateChangClass() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let classState = HHModuleTestsMockViewClassState()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)
        classState.stringValue = randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue)

        eventHandler.state.classState = classState

        eventHandler.beginStateChanges()

        classState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testClassStateRenderRetainBlockStateChangStruct() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        var structState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithClass.state?.stringValue))

        eventHandler.state.structState = structState

        eventHandler.beginStateChanges()

        structState.integerValue = randomIntNotEqual(controller.mockObjectWithClass.state?.integerValue)

        XCTAssertFalse(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")

        eventHandler.commitStateChanges()

        XCTAssert(isEqualState(of: controller, withStateOf: eventHandler), "Render test fail")
    }

    func testStructStateHandler() {
        guard let controller = structController, let eventHandler = structEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let processingStructState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let newStructState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let stateHandler = HHModuleTestsStateHandler<HHModuleTestsStructState>(block: {old, new -> HHModuleTestsStructState in
            var result = new

            if new.structState == newStructState {
                result.structState = processingStructState
            }

            return result
        })

        eventHandler.state.structState = newStructState

        XCTAssert(eventHandler.state.structState == newStructState, "Render test fail")

        eventHandler.stateHandler = stateHandler

        eventHandler.state.structState = newStructState

        XCTAssert(eventHandler.state.structState == processingStructState, "Render test fail")

        eventHandler.stateHandler = nil
    }

    func testClassStateHandler() {
        guard let controller = classController, let eventHandler = classEventHandler else {
            XCTFail("Initialization error")
            return
        }

        let processingStructState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let newStructState = HHModuleTestsMockViewStructState(
            integerValue: randomIntNotEqual(controller.mockObjectWithStruct.state?.integerValue),
            stringValue: randomStringNotEqula(controller.mockObjectWithStruct.state?.stringValue)
        )

        let stateHandler = HHModuleTestsStateHandler<HHModuleTestsClassState>(block: {old, new -> HHModuleTestsClassState in
            let result = new

            if new.structState == newStructState {
                result.structState = processingStructState
            }

            return result
        })

        eventHandler.state.structState = newStructState

        XCTAssert(eventHandler.state.structState == newStructState, "Render test fail")

        eventHandler.stateHandler = stateHandler

        eventHandler.state.structState = newStructState

        XCTAssertFalse(eventHandler.state.structState == processingStructState, "Render test fail")

        eventHandler.state = eventHandler.state

        XCTAssert(eventHandler.state.structState == processingStructState, "Render test fail")

        eventHandler.stateHandler = nil
    }

    // MARK: - Private

    private func isEqualState(of controller: HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsStructState>, HHModuleTestsStructState>,
                      withStateOf eventHandler: HHModuleTestsEventHandler<HHModuleTestsStructState>) -> Bool {
        guard let structState = controller.mockObjectWithStruct.state,
            let classState = controller.mockObjectWithClass.state else {
                return false
        }

        return structState == eventHandler.state.structState
            && classState == eventHandler.state.classState
    }

    private func isEqualState(of controller: HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsClassState>, HHModuleTestsClassState>,
                      withStateOf eventHandler: HHModuleTestsEventHandler<HHModuleTestsClassState>) -> Bool {
        guard let structState = controller.mockObjectWithStruct.state,
            let classState = controller.mockObjectWithClass.state else {
                return false
        }

        return structState == eventHandler.state.structState
            && classState == eventHandler.state.classState
    }

    private func randomIntNotEqual(_ value: Int?) -> Int {
        var result: Int

        repeat {
            result = Int(arc4random_uniform(1_000))
        } while result == (value ?? 0)

        return result
    }

    private func randomStringNotEqula(_ value: String?) -> String {
        var result: String

        repeat {
            result = NSUUID().uuidString
        } while result == (value ?? "")

        return result
    }
}
