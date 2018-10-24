//
//  CellParentConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class CellParentConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (CellParentModuleInput) -> CellParentModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = CellParentViewController()

        let eventHandler = CellParentEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        for index in 0 ..< 36 {
            registerChildModule(for: "User \(index) settings", router: controller, dataSource: controller.dataSource, input: eventHandler)
        }

        return controller
    }

    func registerChildModule(for reuseIdentifire: String, router: ARCHRouter, dataSource: ARCHTableViewDataSource, input: ARCHModuleInput) {
        let module = CellChildEventHandler(title: reuseIdentifire)
        module.router = router
        module.configure(for: dataSource)

        input.registerChildModule(module, for: reuseIdentifire)
    }
}
