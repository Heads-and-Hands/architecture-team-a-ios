//
//  HHModuleTestsEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class HHModuleTestsEventHandler: ARCHEventHandler<HHModuleTestsState>, HHModuleTestsViewOutput, HHModuleTestsModuleInput {

    weak var moduleOutput: HHModuleTestsModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
