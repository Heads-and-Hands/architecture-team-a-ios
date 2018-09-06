//
//  HHModuleTestsMockView.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct HHModuleTestsMockViewStructState: Equatable {

    var integerValue: Int = 0
    var stringValue: String = ""
}

class HHModuleTestsMockViewClassState: Equatable {

    var integerValue: Int = 0
    var stringValue: String = ""

    static func == (lhs: HHModuleTestsMockViewClassState, rhs: HHModuleTestsMockViewClassState) -> Bool {
        return lhs.integerValue == rhs.integerValue
            && lhs.stringValue == rhs.stringValue
    }
}

class HHModuleTestsMockView<T>: ARCHViewRenderable {

    typealias State = T

    var state: T?

    func render(state: T) {
        self.state = state
    }
}

