//
//  HHModuleTestsState.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct HHModuleTestsStructState: ARCHState {

    var structState = HHModuleTestsMockViewStructState()
    var classState = HHModuleTestsMockViewClassState()
}

class HHModuleTestsClassState: ARCHState {

    var structState = HHModuleTestsMockViewStructState()
    var classState = HHModuleTestsMockViewClassState()

    required init() {}
}
