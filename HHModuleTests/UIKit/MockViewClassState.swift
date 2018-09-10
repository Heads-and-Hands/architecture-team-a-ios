//
//  MockViewClassState.swift
//  HHModuleTests
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class MockViewClassState: MockStateProtocol {

    typealias T = Int

    var value: Int

    required init() {
        self.value = randomIntNotEqual(nil)
    }

    func chageRandomly(constraint: Int?) {
        let constraint = constraint ?? value
        self.value = randomIntNotEqual(constraint)
    }

    static func == (lhs: MockViewClassState, rhs: MockViewClassState) -> Bool {
        return lhs.value == rhs.value
    }
}
