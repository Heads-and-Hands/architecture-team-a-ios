//
//  ChildModuleConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ChildModuleConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ChildModuleInput) -> ChildModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ChildModuleViewController()

        let eventHandler = ChildModuleEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler) as? ChildModuleOutput
        }

        controller.output = eventHandler

        return controller
    }
}
