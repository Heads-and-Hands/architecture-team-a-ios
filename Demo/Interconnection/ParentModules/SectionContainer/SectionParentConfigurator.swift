//
//  SectionParentConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class SectionParentConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (SectionParentModuleInput) -> SectionParentModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = SectionParentViewController()

        let eventHandler = SectionParentEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        registerChildModule(for: "main settings", router: controller, dataSource: controller.dataSource, input: eventHandler)

        registerChildModule(for: "subsettings", router: controller, dataSource: controller.dataSource, input: eventHandler)

        return controller
    }

    func registerChildModule(for reuseIdentifire: String, router: ARCHRouter, dataSource: ARCHTableViewDataSource, input: ARCHModuleInput) {
        let module = SectionChildEventHandler()
        module.router = router
        module.configure(for: dataSource)

        input.registerChildModule(module, for: reuseIdentifire)
    }
}
