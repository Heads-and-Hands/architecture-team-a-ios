//
//  SectionListConfigurator.swift
//  architecture
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class SectionListConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (SectionListModuleInput) -> SectionListModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = SectionListViewController()

        let eventHandler = SectionListEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
