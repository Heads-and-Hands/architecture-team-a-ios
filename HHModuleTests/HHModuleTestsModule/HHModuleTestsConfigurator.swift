//
//  HHModuleTestsConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class HHModuleTestsConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (HHModuleTestsModuleInput) -> HHModuleTestsModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = HHModuleTestsViewController<HHModuleTestsEventHandler<HHModuleTestsStructState>, HHModuleTestsStructState>()

        let eventHandler = HHModuleTestsEventHandler<HHModuleTestsStructState>()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
