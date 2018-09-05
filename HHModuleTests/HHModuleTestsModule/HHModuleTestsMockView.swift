//
//  HHModuleTestsMockView.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct HHModuleTestsMockViewState: Equatable {

    var integerValue: Int = 0
    var stringValue: String = ""
}

class HHModuleTestsMockView: ARCHViewRenderable {

    typealias State = HHModuleTestsMockViewState

    var state: HHModuleTestsMockViewState?

    func render(state: HHModuleTestsMockViewState) {
        self.state = state
    }
}

