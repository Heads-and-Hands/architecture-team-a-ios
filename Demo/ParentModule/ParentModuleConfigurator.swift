//
//  ParentModuleConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class ParentModuleConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ParentModuleInput) -> ParentModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ParentModuleViewController<ParentModuleEventHandler<ParentModuleState>, ParentModuleState >()
        let eventHandler = ParentModuleEventHandler<ParentModuleState>()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
