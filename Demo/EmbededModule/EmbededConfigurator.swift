//
//  EmbededConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 19/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class EmbededConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (EmbededModuleInput) -> EmbededModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = EmbededViewController()

        let eventHandler = EmbededEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
