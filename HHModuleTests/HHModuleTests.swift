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

    var controller: HHModuleTestsViewController<HHModuleTestsEventHandler>?
    var eventHandler: HHModuleTestsEventHandler?

    override func setUp() {
        super.setUp()

        controller = HHModuleTestsViewController<HHModuleTestsEventHandler>()

        eventHandler = HHModuleTestsEventHandler()
        eventHandler?.viewInput = controller

        controller?.output = eventHandler
    }
    
    override func tearDown() {

        controller = nil

        eventHandler = nil

        super.tearDown()
    }
    
    func testRender() {
        guard let controller = controller, let eventHandler = eventHandler else {
            XCTFail("Initialization error")
            return
        }

        var mockObjectState = HHModuleTestsMockViewState(integerValue: -1, stringValue: "Mock object state")

        eventHandler.state.mockObjectState = mockObjectState

        XCTAssert(isEqualState(of: controller, state: eventHandler.state), "Render test fail")

        mockObjectState.integerValue = 0

        XCTAssert(isEqualState(of: controller, state: eventHandler.state), "Render test fail")

        let state = HHModuleTestsState(mockObjectState: mockObjectState)

        eventHandler.state = state

        XCTAssert(isEqualState(of: controller, state: eventHandler.state), "Render test fail")
    }

    func isEqualState(of controller: HHModuleTestsViewController<HHModuleTestsEventHandler>, state: HHModuleTestsState) -> Bool {
        guard let mockObjectState = controller.mockObject.state else {
            return false
        }

        return mockObjectState == state.mockObjectState
    }
}
