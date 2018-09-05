//
//  HHModuleTestsViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class HHModuleTestsViewController<Out: HHModuleTestsViewOutput>: ARCHViewController<HHModuleTestsState, Out> {

    let mockObject = HHModuleTestsMockView()

    override func render(state: State) {
        super.render(state: state)
    }
}
