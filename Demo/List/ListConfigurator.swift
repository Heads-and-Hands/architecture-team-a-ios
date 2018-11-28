//
//  ListConfigurator.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class ListConfigurator: ARCHModuleConfigurator {

    typealias ModuleIO = (ListModuleInput) -> ListModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var module: ARCHModule {
        let controller = ListViewController()

        let eventHandler = ListEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
