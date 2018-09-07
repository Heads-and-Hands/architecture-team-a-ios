//
//  MockViewClassState.swift
//  HHModuleTests
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class MockViewClassState: Equatable, ARCHState {
    var integerValue: Int
    var stringValue: String

    required init() {
        integerValue = 0
        stringValue = ""
    }

    static func == (lhs: MockViewClassState, rhs: MockViewClassState) -> Bool {
        return lhs.integerValue == rhs.integerValue && lhs.stringValue == rhs.stringValue
    }
}
